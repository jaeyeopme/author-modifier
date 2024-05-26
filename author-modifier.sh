#!/bin/bash

# Fuction to display usage instructions
usage() {
    echo "Usage: $0 --new-name=NEW_NAME --new-email=NEW_EMAIL --old-name=OLD_NAME --old-email=OLD_EMAIL --branch=BRANCH [PATH]"
    exit 1
}

# Initialize input variables
OLD_NAME="*"
OLD_EMAIL="*"
NEW_NAME=""
NEW_EMAIL=""
BRANCH="*"
PATH_DIR=""

# Parse input variables
while [ "$#" -gt 0 ]; do
    case "$1" in
        --old-name=*) OLD_NAME="${1#*=}"; shift ;;
        --old-email=*) OLD_EMAIL="${1#*=}"; shift ;;
        --new-name=*) NEW_NAME="${1#*=}"; shift ;;
        --new-email=*) NEW_EMAIL="${1#*=}"; shift ;;
        --branch=*) BRANCH="${1#*=}"; shift ;;
        *)
            if [ -z "$PATH_DIR" ]; then
                PATH_DIR="$1"
                shift
            else
                usage
            fi
            ;;
    esac
done

# Validate input variables
if [ -z "$NEW_NAME" ] || [ -z "$NEW_EMAIL" ]; then
    usage
fi

# Set execution path: If PATH_DIR is not set, use the current directory
if [ -n "$PATH_DIR" ]; then
    cd "$PATH_DIR" || { echo "Error: Could not modify directory to $PATH_DIR"; exit 1; }
else
    PATH_DIR=$(pwd)
fi

echo "Running in directory: $PATH_DIR"

# Save the current remote URL
REMOTE_URL=$(git config --get remote.origin.url)

# Function to modify author information
modify_author() {
    local old_name=$1
    local old_email=$2
    local new_name=$3
    local new_email=$4

    git filter-repo --force --commit-callback "
    if '$old_name' == '*' or commit.author_name == b'$old_name':
        commit.author_name = b'$new_name'
    if '$old_email' == '*' or commit.author_email == b'$old_email':
        commit.author_email = b'$new_email'
    if '$old_name' == '*' or commit.committer_name == b'$old_name':
        commit.committer_name = b'$new_name'
    if '$old_email' == '*' or commit.committer_email == b'$old_email':
        commit.committer_email = b'$new_email'
    " --force
}

# Process all branches or specific branch
if [ "$BRANCH" == "*" ]; then
    for branch in $(git for-each-ref --format='%(refname:short)' refs/heads/); do
        git checkout "$branch"
        if [ $? -ne 0 ]; then
            echo "Error: Could not checkout branch $branch"
            exit 1
        fi
        modify_author "$OLD_NAME" "$OLD_EMAIL" "$NEW_NAME" "$NEW_EMAIL"
    done
else
    # Checkout the specified branch
    if [ -n "$BRANCH" ]; then
        git checkout "$BRANCH"
        if [ $? -ne 0 ]; then
            echo "Error: Could not checkout branch $BRANCH"
            exit 1
        fi
    fi

    # Modify author information
    modify_author "$OLD_NAME" "$OLD_EMAIL" "$NEW_NAME" "$NEW_EMAIL"
fi

# Restore the remote URL
if [ -n "$REMOTE_URL" ]; then
    git remote add origin "$REMOTE_URL"
fi

