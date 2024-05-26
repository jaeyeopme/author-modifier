# Author Modifier

`author-modifier.sh` is a shell script that allows you to batch change the author name and email of commits in a Git repository. This script can operate on specific branches or all branches and can change specific author information or all author information.

## Features

- Change specific author names and emails
- Change all author names and emails
- Operate on specific branches or all branches
- Execute in a specified directory

## Usage

### Prerequisites

- Unix-like system (Linux, macOS) or Windows (can be run using WSL)
- Git must be installed
- `git-filter-repo` must be installed.

### How to Run

#### 1. Download the author-modifier.sh script.

```sh
curl -O https://github.com/jaeyeopme/author-modifier/main/author-modifier.sh
```

#### 2. Open the command line and navigate to the directory where the script is located.

#### 3. Run the following command to execute the script:

```sh
./author-modifier.sh --old-name="old_name" --old-email="old_email@example.com" --new-name="new_name" --new-email="new_email@example.com" --branch="branch_name" [path_to_repository]
```

#### 4. Options

- `--new-name` is the new author name.
- `--new-email` is the new author email.
- `--old-name` is the current author name. If not specified, all names will be changed.
- `--old-email` is the current author email. If not specified, all emails will be changed.
- `--branch` is the branch to be changed. If not specified, all branches will be changed.
- `[path_to_repository]` is the path to the repository. If not specified, the current directory will be used.

#### 5. Push changes to the remote repository (if needed):

```sh
git push --set-upstream origin "branch_name --force
```

## Example

- Change all author names and emails in all branches of the specified repository:

```sh
./author-modifier.sh --new-name="new_name" --new-email="new_email@example.com" /path/to/repository
```

- Change specific author name and email in a specific branch:

```sh
./author-modifier.sh --new-name="new_name" --new-email="new_email@example.com" --old-name="old_name" --old-email="old_email@example.com" --branch="branch_name" /path/to/repository
```
