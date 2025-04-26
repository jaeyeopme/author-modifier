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
- `git-filter-repo` must be installed. You can install it using:

  ```sh
  pip install git-filter-repo
  ```

  Or follow the installation instructions at: <https://github.com/newren/git-filter-repo>

### How to Run

#### 1. Download the author-modifier.sh script

```sh
curl -O https://raw.githubusercontent.com/jaeyeopme/author-modifier/main/author-modifier.sh
```

#### 2. Open the command line and navigate to the directory where the script is located

#### 3. Run the following command to execute the script

```sh
./author-modifier.sh --old-name="old_name" --old-email="old_email@example.com" --new-name="new_name" --new-email="new_email@example.com" --branch="branch_name" [path_to_repository]
```

#### 4. Options

- `--new-name` - New author name to set. Required if `--new-email` is not provided.
- `--new-email` - New author email to set. Required if `--new-name` is not provided.
- `--old-name` - Old author name to replace. Default: '\*' (matches all names).
- `--old-email` - Old author email to replace. Default: '\*' (matches all emails).
- `--branch` - Git branch to modify. Default: '\*' (processes all branches).
- `[path_to_repository]` - Path to the Git repository. Default: current directory.

#### 5. Push changes to the remote repository (if needed)

```sh
git push --set-upstream origin branch_name --force
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
