# Git Cheater

## BFG 

1. **Rm files from ALL commits**:
```bash
bfg --delete-files 'credentials.json'
git reflog expire --expire=now --all && git gc --prune=now --aggressive
```

2. **Force-push the cleaned history**:
```bash
git push origin --force --all
git push origin --force --tags
```

---

## Rebase 

[Approve Testing]
1. **Bring approved testing branch modifications into the main branch**:
```bash
git checkout testing          # Go to your feature branch
git pull                     # Make sure it's up to date
git rebase main              # Re-apply changes as if from main
# (Resolve conflicts if any)
git checkout main
git merge testing            # Now this is a fast-forward merge (no merge commit)
git push
```

[After Rebase]
2. **After bringing the testing branch modifications over to main, delete the branch**:
```bash
git branch -d testing
git push origin --delete testing
git branch -vv                       # Check local branch tracking remote
git push --set-upstream origin main  # Set remote if missing 
```

---

## Add Scopes w GH CLI

```bash
gh auth refresh -s workflow read:gpg_key admin:ssh_signing_key admin:public_key
```

---

## Get User Token

```bash
GH_TOKEN=$(gh auth token --user 4ndr0666) gh api /user | jq .login
```

---

## Pull Updates (Ensuring local changes are saved) 

1. **Save all local changes first** (tracked + untracked)
```shell
git stash push -u -m "WIP"
```

2. **Lineraly update branch with a rebase** 
```shell
git pull --rebase
```

3. **Bring stash back, staging exactly as before**
```shell
git stash pop --index
```

4. **Fix any conflicts, then**
```shell
git add <fixed> ; git rebase --continue   # only if conflicts + rebasing
git commit -am "your message"
git push
```

---

## Git Stash

1. **Always keep untracked files**:
```shell
git config --global stash.saveIncludeUntracked true
```

2. **Auto‑stash on every rebase/pull**:
```shell
git config --global rebase.autoStash true
```

3. **See what’s in a stash, including untracked**:
```shell
git stash show -p -u stash@{0}
```

4. **Name your stashes**:
```shell
git stash push -u -m "fix‑menu‑layout"
```

---

## Automatically Setup Upstream 

```shell
git config --global push.autoSetupRemote true
```

---

## List all root-owned files in repo

```shell
git ls-files -s | awk '$3 ~ /^0*0?$/ {next} $4 ~ /^git\/dir\/to_search_in\// {print $4}'
```

---

## Quick scan for leftover large blobs (≥ 90 MB)

- Method 1
```shell
git rev-list --objects --all |
git cat-file --batch-check='%(objectsize) %(rest)' |
awk '$1 > 100*1024*1024 {print $0}'
```

- Method 2
```shell
git rev-list --objects --all |
  git cat-file --batch-check='%(objectname) %(objecttype) %(objectsize) %(rest)' |
  awk '$3 > 90000000 {printf "%.2f MB\t%s\n", $3/1048576, $4}'
```

---

## Changelog Generation:

**Noticed @devaslife using a pkg called cz-cli and found it on github. It automates changelogs**

```bash
git clone https://github.com/commitizen/cz-cli.git
```

---

## Reconnect/Clean Old Repo:

**Initialize and handle the old data**

```bash
git init
git stash --all
git stash list
git stash create
git stash show
```

**After reviewing the data you want to keep, either do a** `git stash create` **to save all**
**data locally and not on the reflog. Or explicitly move the files elsewhere (I do both to be safe)**
`git stash clear` **will then delete all the saved data when you're ready**

```bash
git stash clear       
git remote add upstream https://github.com/repo/url.git
git branch --set-upstream-to=upstream/main
gh remote add origin https://github.com/repo/url.git
gh tidy
gh repo sync
```

## Basic LFS Commands

```bash
git lfs untrack "*.zip" # Replace with the file type you need to untrack
git add .gitattributes
git lfs prune            # Clean up old and unused LFS files
git lfs dedup            # Deduplicate LFS files
git lfs fsck             # Check for corrupt or missing LFS files
git push --all origin main  # Push all branches to the remote 'main'
git lfs push --all github.com:4ndr0666/dotfiles.git  # Push all LFS files to the specified remote
```

## Additional LFS Resolutions

```bash
git lfs ls-files  # List all files tracked by LFS
```

Example output:

```plaintext
98464f72e2 * config/...file.zip
98aca01b03 * config/file.tar
99d6e4d676 - home/.................tar.gz
009967702a - pkgs/hooks.......tar.gz
```

### Steps to Resolve

1. **Untrack Specific File Types:**

   ```bash
   git lfs untrack "*.ext/file"  # Replace with the file extension or specific file
   ```

2. **Add changes to `.gitattributes`:**

   ```bash
   git add .gitattributes
   ```

3. **Clean and Check LFS Files:**

   ```bash
   git lfs prune
   git lfs dedup
   git lfs fsck
   ```

4. **Push Changes to Remote:**

   ```bash
   git push --all origin main
   git lfs push --all github.com:4ndr0666/dotfiles.git
   ```

## Git LFS Locking API

If you encounter an error regarding LFS locking, you can disable lock verification with:

```bash
git config lfs.https://github.com/4ndr0666/scr.git/info/lfs.locksverify false
```

This disables the lock verification for the specific repository.

## Restoring Deleted Files

### Step-by-Step Guide:

1. **Checkout the Parent Commit:**

   ```bash
   git checkout cecb069
   ```

2. **Create a New Branch (Recommended):**

   ```bash
   git checkout -b restore-branch
   ```

3. **Merge Changes into Main Branch:**

   ```bash
   git checkout master  # or 'main'
   git merge restore-branch
   ```

4. **Push the Restored Files to Remote:**

   ```bash
   git push origin master  # or 'main'
   ```

## Removing Large Files from Git History with BFG Repo-Cleaner

Accidentally committing large files can cause push failures due to repository hosting limits (e.g., GitHub's 100 MB limit). This section guides you through removing large files from your Git history using BFG Repo-Cleaner.

### Prerequisites

- **Java Installed**: BFG Repo-Cleaner is a Java-based tool.
- **BFG Repo-Cleaner Downloaded**: [Download BFG](https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar)

### Step-by-Step Guide

1. **Clone Your Repository as a Bare Repository:**

   ```bash
   cd /path/to/syncing/
   rm -rf scr.git
   git clone --bare scr scr.git
   ```

2. **Create a Mirror Clone for Backup:**

   ```bash
   git clone --mirror scr scr-backup.git
   ```

3. **Set the Bare Repository as the Remote for the Mirror Clone:**

   ```bash
   cd scr-backup.git
   git remote set-url origin /path/to/syncing/scr.git
   ```

4. **Run BFG Repo-Cleaner to Remove the Large File:**

   ```bash
   java -jar ~/bin/bfg.jar --delete-files permissions_manifest.acl
   ```

5. **Finalize the Repository Cleanup:**

   ```bash
   git reflog expire --expire=now --all
   git gc --prune=now --aggressive
   ```

6. **Force Push the Cleaned History to the Bare Repository:**

   ```bash
   command git push --mirror origin
   ```

7. **Reset Your Local Working Repository to Match the Cleaned Remote:**

   ```bash
   cd /path/to/scr/
   git fetch origin
   git reset --hard origin/main
   ```

8. **Verify Removal of the Large File:**

   ```bash
   git log --stat | grep permissions_manifest.acl
   ```

9. **(Optional) Add GitHub as a Remote and Push:**

   ```bash
   git remote add github git@github.com:4ndr0666/scr.git
   command git push --mirror github
   ```

10. **Implement Preventative Measures:**

    - **Update `.gitignore`:**

      ```bash
      echo "permissions/PermMaster/permissions_manifest.acl" >> .gitignore
      git add .gitignore
      git commit -m "Add permissions_manifest.acl to .gitignore to prevent accidental commits"
      git push origin main
      ```

    - **Implement a Pre-Commit Hook to Reject Large Files:**

      ```bash
      # Create the pre-commit hook script
      nano .git/hooks/pre-commit
      ```

      **Add the Following Content:**

      ```bash
      #!/bin/bash
      max_size=100000  # 100 MB in KB

      for file in $(git diff --cached --name-only); do
          if [ -f "$file" ]; then
              size=$(du -k "$file" | cut -f1)
              if [ "$size" -gt "$max_size" ]; then
                  echo "Error: Attempting to commit large file '$file' ($size KB)."
                  exit 1
              fi
          fi
      done

      exit 0
      ```

      **Make the Hook Executable:**

      ```bash
      chmod +x .git/hooks/pre-commit
      ```

    - **Use Git Large File Storage (Git LFS) for Necessary Large Files:**

      ```bash
      # Install Git LFS
      git lfs install

      # Track the large file
      git lfs track "permissions/PermMaster/permissions_manifest.acl"

      # Update .gitattributes
      echo "permissions/PermMaster/permissions_manifest.acl filter=lfs diff=lfs merge=lfs -text" >> .gitattributes
      git add .gitattributes

      # Add and commit the large file using LFS
      git add permissions/PermMaster/permissions_manifest.acl
      git commit -m "Track permissions_manifest.acl with Git LFS"

      # Push changes
      git push origin main
      ```

      **Note:** Git LFS has its own storage quotas and pricing on GitHub.

11. **Regularly Monitor Repository Size:**

    - **Use `git-sizer`:**

      ```bash
      wget https://github.com/github/git-sizer/releases/download/v1.11.0/git-sizer-1.11.0-linux-amd64 -O ~/bin/git-sizer
      chmod +x ~/bin/git-sizer
      git-sizer
      ```

### Troubleshooting

- **BFG Errors: Can Only Match on Filename, Not Path**

  - **Cause:** BFG's `--delete-files` option only matches filenames, not their paths.
  - **Solution:** Provide only the filename without any directory paths.

    ```bash
    java -jar ~/bin/bfg.jar --delete-files permissions_manifest.acl
    ```

- **Pushing to a Non-Bare Repository:**

  - **Error Message:**

    ```
    remote: error: refusing to update checked out branch: refs/heads/main
    remote: error: By default, updating the current branch in a non-bare repository
    remote: is denied...
    ```

  - **Solution:** Ensure you're pushing to a **bare repository**. Recreate the bare repository if necessary.

    ```bash
    # Remove existing non-bare repository if exists
    rm -rf /Nas/Build/git/syncing/scr.git

    # Create a new bare repository
    git clone --bare scr scr.git
    ```

- **Fatal Error: `--mirror` can't be combined with refspecs**

  - **Cause:** Using `--mirror` alongside specific refspecs (e.g., `main`) is invalid.
  - **Solution:** Use `--mirror` without specifying branches.

    ```bash
    command git push --mirror origin
    ```

---

## 🚀 **Automating the Cleaning Process with a Script**

To streamline the process of removing large files from your Git history, you can use the following **Bash script**. This script automates cloning, running BFG, cleaning, and pushing the cleaned history.

### **Script: `clean_git_history.sh`**

```bash
#!/bin/bash

# Description:
# This script automates the process of removing a specified large file from a Git repository's history using BFG Repo-Cleaner.
# It creates a bare repository, runs BFG, cleans the repository, and force pushes the changes.

# Usage:
# ./clean_git_history.sh /path/to/bare-repo.git filename_to_remove

# Example:
# ./clean_git_history.sh /Nas/Build/git/syncing/scr.git permissions_manifest.acl

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 /path/to/bare-repo.git filename_to_remove"
    exit 1
fi

BARE_REPO="$1"
FILE_TO_REMOVE="$2"

# Check if BFG is installed
if ! command -v java &> /dev/null; then
    echo "Java is not installed. Please install Java to use BFG Repo-Cleaner."
    exit 1
fi

if [ ! -f ~/bin/bfg.jar ]; then
    echo "BFG Repo-Cleaner not found at ~/bin/bfg.jar. Please download it first."
    exit 1
fi

# Check if the bare repository exists
if [ ! -d "$BARE_REPO" ]; then
    echo "Bare repository '$BARE_REPO' does not exist."
    exit 1
fi

# Create a temporary mirror clone
TEMP_DIR=$(mktemp -d)
echo "Cloning the bare repository to temporary directory..."
git clone --mirror "$BARE_REPO" "$TEMP_DIR"

# Run BFG to remove the specified file
echo "Running BFG to delete '$FILE_TO_REMOVE'..."
java -jar ~/bin/bfg.jar --delete-files "$FILE_TO_REMOVE" "$TEMP_DIR"

# Navigate to the temporary clone
cd "$TEMP_DIR" || exit

# Perform garbage collection
echo "Performing garbage collection..."
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# Force push the cleaned history back to the bare repository
echo "Force pushing the cleaned history back to '$BARE_REPO'..."
git push --force --mirror "$BARE_REPO"

# Cleanup
echo "Cleaning up temporary directory..."
rm -rf "$TEMP_DIR"

echo "Cleaning process completed successfully."

exit 0
```

### **How to Use the Script:**

1. **Save the Script:**

   Save the above script as `clean_git_history.sh` in a directory of your choice, for example, `~/scripts/`.

   ```bash
   nano ~/scripts/clean_git_history.sh
   ```

   *(Paste the script content and save.)*

2. **Make the Script Executable:**

   ```bash
   chmod +x ~/scripts/clean_git_history.sh
   ```

3. **Run the Script:**
   
   Provide the path to your bare repository and the filename you want to remove.

   ```bash
   ~/scripts/clean_git_history.sh /Nas/Build/git/syncing/scr.git permissions_manifest.acl
   ```

   **Script Flow:**
   - **Clones** the bare repository to a temporary directory.
   - **Runs BFG Repo-Cleaner** to remove the specified file.
   - **Performs Git garbage collection** to clean up.
   - **Force pushes** the cleaned history back to the bare repository.
   - **Cleans up** the temporary directory.

4. **Post-Script Steps:**
   
   After running the script, **reset your local working repository** to align with the cleaned remote.

   ```bash
   # Navigate to your local repository
   cd /Nas/Build/git/syncing/scr/

   # Fetch the latest changes
   git fetch origin

   # Reset your local main branch to match the remote
   git reset --hard origin/main
   ```

5. **Verify the Cleanup:**
   
   Ensure the large file has been removed from history.

   ```bash
   git log --stat | grep permissions_manifest.acl
   ```

   **Expected Output:** No results, indicating successful removal.

6. **(Optional) Push to GitHub:**
   
   If you maintain a GitHub remote and wish to push the cleaned history.

   ```bash
   # Add GitHub as a remote if not already added
   git remote add github git@github.com:4ndr0666/scr.git

   # Push the cleaned history to GitHub
   command git push --mirror github
   ```

   **Note:** Ensure that the GitHub repository is **bare** to prevent push conflicts.
