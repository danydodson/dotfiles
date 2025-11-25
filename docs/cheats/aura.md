### #**Aura Package Manager - Admin-Level Cheat Sheet**

---

#### **1. Installation and Removal**

- **Install a Package**
  ```bash
  sudo aura -A <package_name>
  ```
  - Installs a package from the Arch User Repository (AUR).
  - **Options**: `--noconfirm` (skip confirmation), `--needed` (skip if installed)

- **Remove a Package**
  ```bash
  sudo aura -R <package_name>
  ```
  - Removes a specified package.
  - **Options**: `--cascade` (remove dependencies), `--nosave` (prevent backup of modified files)

- **Install Multiple Packages**
  ```bash
  sudo aura -A <package1> <package2> ...
  ```
  - Installs multiple AUR packages in a single command.

---

#### **2. Updates and System Management**

- **Update Packages**
  ```bash
  sudo aura -Su
  ```
  - Syncs with the repositories and upgrades all out-of-date packages.
  - **Options**: `--aur` (only update AUR packages), `--sysupgrade` (only system packages)

- **Database Sync and Update**
  ```bash
  sudo aura -Syu
  ```
  - Updates the package database and upgrades the system to the latest versions of packages.

- **Downgrade a Package**
  ```bash
  sudo aura -B <package_name>
  ```
  - Downgrades a package to a previous version if available in cache.
  - **Options**: `--all` (downgrade all cached versions)

---

#### **3. Cache Management and Cleanup**

- **Clear Package Cache**
  ```bash
  sudo aura -Sc
  ```
  - Clears the package cache, freeing up space by removing old package versions.

- **List Cache Contents**
  ```bash
  sudo aura -C
  ```
  - Lists all packages stored in the cache for a quick overview of available versions.

- **Clean All Cached Packages**
  ```bash
  sudo aura -Scc
  ```
  - Fully clears all cached packages (useful for reclaiming disk space).

---

#### **4. Dependency and Integrity Handling**

- **View Package Dependencies**
  ```bash
  aura -Qi <package_name>
  ```
  - Lists dependencies of a given package for dependency management.

- **Check for Broken Dependencies**
  ```bash
  sudo aura -D --check
  ```
  - Scans installed packages for broken dependencies or unsatisfied requirements.

- **Verify Package Integrity**
  ```bash
  sudo aura -Qc <package_name>
  ```
  - Checks the integrity of a package’s files against its database to identify changes.

---

#### **5. Debugging and Troubleshooting**

- **Show Recent Errors**
  ```bash
  aura -G
  ```
  - Displays recent log entries or errors to assist with debugging installation issues.

- **Verbose Output**
  ```bash
  sudo aura -A <package_name> --debug
  ```
  - Enables verbose mode, displaying additional information useful for troubleshooting.

- **Resolve Unresolved Dependencies**
  ```bash
  sudo aura -Syu --needed
  ```
  - Attempts to install only packages that are missing dependencies, skipping existing ones.

---

### #**Aura Package Manager - Extended Admin-Level Cheat Sheet pt 2**

---

#### **1. Installation and Removal (Advanced)**

- **Install Specific Package Version**
  ```bash
  sudo aura -A <package_name>=<version>
  ```
  - Installs a specified version of a package if available in the repositories.
  
- **Force Reinstall a Package**
  ```bash
  sudo aura -A <package_name> --reinstall
  ```
  - Reinstalls the package, even if it is already installed.
  - **Options**: Use with `--nodeps` to ignore dependencies during reinstall.

- **Orphan Package Removal**
  ```bash
  sudo aura -Rns $(sudo aura -Qdtq)
  ```
  - Cleans up orphaned packages, removing unnecessary dependencies left behind by uninstalled packages.

---

#### **2. Updates and System Management (Advanced)**

- **Full System Upgrade with Backup**
  ```bash
  sudo aura -Syu --backup
  ```
  - Backs up all package versions and system files before upgrading the system.

- **Partial Upgrade**
  ```bash
  sudo aura -S <package_name>
  ```
  - Updates only a specified package rather than all available updates, useful for avoiding rolling-release pitfalls.

- **List Outdated AUR Packages**
  ```bash
  aura -Au
  ```
  - Lists all AUR packages with available updates.

---

#### **3. Cache Management and Cleanup (Advanced)**

- **Restore from Cache**
  ```bash
  sudo aura -A <package_name> --cached
  ```
  - Reinstalls a package directly from cache without needing to re-download.

- **Clear All Except Latest**
  ```bash
  sudo aura -Scc --keep
  ```
  - Clears the cache but retains the most recent version of each package.

- **Download Package without Installing**
  ```bash
  sudo aura -Dw <package_name>
  ```
  - Downloads a package and its dependencies without installing them; useful for offline installation.

---

#### **4. Dependency and Integrity Handling (Advanced)**

- **Check Optional Dependencies**
  ```bash
  aura -Qi <package_name> | grep "Optional Deps"
  ```
  - Lists optional dependencies for a package, allowing admins to install additional features if desired.

- **Dependency Tree Analysis**
  ```bash
  aura -Qdt
  ```
  - Shows a full tree of dependencies for each package, useful for in-depth dependency management.

- **List Reverse Dependencies**
  ```bash
  aura -Q --whatdepends <package_name>
  ```
  - Shows packages that depend on a specific package, helping admins assess dependency impact before removal.

---

#### **5. Debugging and Troubleshooting (Advanced)**

- **Run Dry-Run of Installation/Upgrade**
  ```bash
  sudo aura -Syu --print
  ```
  - Simulates an upgrade and prints actions without making changes, allowing review of updates before applying.

- **Log All Command Outputs**
  ```bash
  sudo aura -A <package_name> 2>&1 | tee /path/to/logfile.log
  ```
  - Logs all output to a file for later review, helping in-depth troubleshooting.

- **Interactive Debug Mode**
  ```bash
  sudo aura -Syu --interactive
  ```
  - Prompts for each step during upgrades and installations, allowing granular control and troubleshooting.

---

#### **6. Administrative and System-Specific Commands**

- **Enable Verbose Mode**
  ```bash
  sudo aura -v
  ```
  - Activates verbose output, providing extra details during all command executions.

- **Display Aura Configuration**
  ```bash
  aura -C
  ```
  - Lists current configuration options for Aura, showing customized paths, cache locations, and more.

- **Audit Installed Packages**
  ```bash
  sudo aura -Q | grep -e "[installed]" -e "[explicit]"
  ```
  - Audits and categorizes all installed packages, identifying which were explicitly installed by the user vs. dependencies.

---

### #**Aura Package Manager - Extended Admin-Level Cheat Sheet (Continued)**

---

#### **7. Security and Package Verification**

- **Verify Package Signatures**
  ```bash
  sudo aura -S <package_name> --verify
  ```
  - Checks GPG signatures for packages to ensure integrity.
  - **Usage Note**: Essential for admins handling AUR packages with external sources.

- **Install with Custom Keyring**
  ```bash
  sudo aura -A <package_name> --keyring <keyring_name>
  ```
  - Specifies a custom keyring for installing packages, ensuring the trusted origin of packages.

- **Check Package Integrity Against Database**
  ```bash
  sudo aura -Qk <package_name>
  ```
  - Verifies installed package files against their original hashes to detect tampering.

---

#### **8. Package Metadata and System Info**

- **Display All Installed Packages**
  ```bash
  aura -Qe
  ```
  - Lists all explicitly installed packages, excluding dependencies.

- **List All Foreign (AUR) Packages**
  ```bash
  aura -Qm
  ```
  - Outputs all packages installed from the AUR, aiding management of non-repository software.

- **Display Detailed Package Info**
  ```bash
  aura -Qi <package_name>
  ```
  - Shows in-depth metadata for a specified package, including dependencies, installation date, and more.

---

#### **9. Automation and Scripting Integrations**

These one-liners and command combinations are designed for admins aiming to automate tasks and maximize command utility.

- **Automate Full System Update and Cleanup**
  ```bash
  sudo aura -Syu && sudo aura -Scc
  ```
  - Performs a full system upgrade and clears all cached packages, keeping the system up-to-date and reclaiming disk space.

- **Find and Remove Orphaned Packages in One Line**
  ```bash
  sudo aura -Rns $(sudo aura -Qdtq)
  ```
  - Locates and removes orphaned packages in a single command.

- **Automated AUR Update Check and Install**
  ```bash
  aura -Au | xargs -r sudo aura -A
  ```
  - Checks for available updates on AUR packages and installs them if updates are found.

---

#### **10. Advanced Admin One-Liners**

Here, we introduce more advanced command integrations for streamlined system management tasks.

- **List Packages Updated in the Last 7 Days**
  ```bash
  aura -Q | awk '{print $1, $2}' | xargs aura -Qi | grep "Install Date" | grep "$(date +%Y-%m-%d)"
  ```
  - Filters and lists all packages that have been updated within the past week.

- **Backup Installed Package List to a File**
  ```bash
  aura -Qe > /path/to/backup/installed_packages_list.txt
  ```
  - Creates a backup of all explicitly installed packages for easy reinstallation.

- **Reinstall All Packages from Backup**
  ```bash
  xargs sudo aura -A < /path/to/backup/installed_packages_list.txt
  ```
  - Restores packages from the list, useful in system recovery scenarios.

---

#### **11. Routine Maintenance and Monitoring Commands**

- **List All Outdated Packages (Including System and AUR)**
  ```bash
  aura -Qu
  ```
  - Identifies all outdated packages across both system and AUR repositories.

- **Find Unused Packages Exceeding a Size Limit**
  ```bash
  aura -Q | awk '{print $1}' | xargs sudo aura -Qi | grep -A5 "Installed Size" | grep -E "(Package|Installed Size: [5-9][0-9]{2}M)"
  ```
  - Scans installed packages, identifying those with significant size that haven’t been used recently.
