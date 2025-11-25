### 🔐 Permissions Cheat-sheet 🔐

#### Octal Permission Meaning

| **CHMOD** | **Symbolic** |            **Description**               |    **Use Cases**        |
|-----------|--------------|--------------------------------------------------------------------|
| **400**   | `r--r-----`  | Read ⇝ UG                                | Shared read-only files  |
| **600**   | `rw-------`  | Read/write ⇝ U                           | Private `~/.ssh/id_rsa` |
| **644**   | `rw-r--r--`  | Read/write ⇝ U; read ⇝ O                 | Configs `/etc/passwd`   |
| **700**   | `rwx------`  | Read/Write/Exe ⇝ U                       | Exec,  Personal `~/bin` |
| **755**   | `rwxr-xr-x`  | Read/Write/Exe ⇝ U; Read/Exe ⇝ G; Exe -O | Binaries `/usr/bin`     |
| **775**   | `rwxrwxr-x`  | Read/Write/Exe ⇝ UG; Read/Exe ⇝ O        | Collaborate `/var/www`  |
| **777**   | `rwxrwxrwx`  | Read/Write/Exe ⇝ UGO                     | All access              |
| **440**   | `r--r-----`  | Read ⇝ UG                                | Shared read-only files  |
| **550**   | `r-xr-x---`  | Read/Exe ⇝ UG                            | Shared executables      |
| **750**   | `rwxr-x---`  | Read/Write/Exe ⇝ U; Read/Exe ⇝ G         | Restricted shared dirs  |
| **664**   | `rw-rw-r--`  | Read/write ⇝ UG; Read ⇝ O                | Collaborative files     |

---

- **First digit**: Owner/user permissions
- **Second digit**: Group permissions
- **Third digit**: Others (world) permissions

Each digit is a sum of its component permissions:

- **4**: Read (`r`)
- **2**: Write (`w`)
- **1**: Execute (`x`)
- **0**: No permission

For example, `7` (4+2+1) grants read, write, and execute permissions.

---

### **Special Permission Bits**

- **Setuid (`4xxx`)**: Executes file with owner's permissions.
- **Setgid (`2xxx`)**: Executes file with group's permissions; new files inherit group ID.
- **Sticky Bit (`1xxx`)**: Only owner or root can delete/modify files in directory.

**Examples:**

- **4755**: Setuid + `rwxr-xr-x`
- **2775**: Setgid + `rwxrwxr-x`
- **1755**: Sticky Bit + `rwxr-xr-x`

**Use Cases:**

- **Setuid**: Programs like `passwd` needing elevated privileges.
- **Setgid**: Shared directories for group collaboration.
- **Sticky Bit**: `/tmp` to prevent users from deleting others' files.

###  📌**Caveats**

1. **Handle Symbolic Links Appropriately:**
   - Prevent unintended modifications by not following symbolic links:
     ```bash
     find "$path" -type d -exec chmod "$dir_perm" {} \; -o -type f -exec chmod "$file_perm" {} \;
     ```

2. **Secure Log Files:**
   - Ensure log files have restrictive permissions:
     ```bash
     chmod 600 "$LOG_FILE"
     ```

3. **Crontab:**
   - Ensure main dir `/var/spool/cron` is correctly set:       
     ```bash
     sudo chown root:crontab /var/spool/cron
     sudo chmod 755 /var/spool/cron
     ```
   - Indivdual users:
     ```bash
     sudo chown <username>:crontab /var/spool/cron/crontabs/<username>
     sudo chmod 600 /var/spool/cron/crontabs/<username>
     ```
     
### ⚠️**Default Settings**

|      **File/Directory**        | **Owner** | **Group** | **CHMOD** |         **Description**              |
|--------------------------------|-----------|-----------|-----------|--------------------------------------|
| **/etc/sudoers**               | root      | root      | `440`     | Sudo privileges configuration        |
| **/etc/passwd**                | root      | root      | `644`     | User account information             |
| **/etc/shadow**                | root      | shadow    | `640`     | Secure user password information     |
| **/etc/ssh/ssh_config**        | root      | root      | `644`     | SSH client configuration             |
| **~/.ssh/id_rsa**              | user      | user      | `600`     | Private SSH key                      |
| **~/.ssh/id_rsa.pub**          | user      | user      | `644`     | Public SSH key                       |
| **~/.gnupg/**                  | user      | user      | `700`     | GnuPG configuration and keys         |
| **/usr/bin/**                  | root      | root      | `755`     | Executable binaries                  |
| **/var/www/**                  | root      | http      | `775`     | Web server files                     |
| **/var/spool/cron/**           | root      | crontab   | `755`     | Crontab directory                    |
| **/var/spool/cron/crontabs/**  | root      | crontab   | `1733`    | User crontab files with sticky bit   |
| **/etc/ssh/sshd_config**       | root      | root      | `600`     | SSH daemon configuration             |
| **/etc/hosts.allow**           | root      | root      | `644`     | TCP wrappers allow rules             |
| **/etc/hosts.deny**            | root      | root      | `644`     | TCP wrappers deny rules              |
| **/etc/profile**               | root      | root      | `644`     | System-wide environment              |
| **/etc/bash.bashrc**           | root      | root      | `644`     | System-wide bash                     |
| **/var/log/**                  | root      | root      | `750`     | Log directory                        |
| **/usr/local/bin/**            | root      | root      | `755`     | Local binaries                       |
| **/home/<user>/**              | user      | user      | `755`     | Home directory                       |
| **/home/<user>/.bashrc**       | user      | user      | `644`     | User's bashrc                        |
| **/home/<user>/.bash_profile** | user      | user      | `644`     | Bash profile                         |
| **/tmp**                       |           |           | `1777`    | FS for memory read access            | 
