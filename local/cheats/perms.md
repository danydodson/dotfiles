# Permissions Cheat-sheet

## Chmod Usage

### Read for User
Usage: Private files
**chmod 400**  r--------

### Read and write for User
Usage: Private files (e.g., `~/.ssh/id_rsa`)
chmod **600**  rw-------

### Read and write for User; Read for Others
Usage: General configuration files (e.g., `/etc/passwd`)
chmod **644**  rw-r--r--

### Read, write, execute for User
Usage: Executable scripts, personal directories (`~/bin`)
chmod **700**  rwx------

### Read, write, execute for User; Read, execute for Others
Usage: System binaries (`/usr/bin`), shared directories
chmod **755**  rwxr-xr-x

### Read, write, execute for User; Read, write, execute for Group; Read, execute for Others
Usage: Collaborative directories (`/var/www`)
chmod **775**   rwxrwxr-x

### Read, write, execute for User; Read, write, execute for Group; Read, write, execute for Others
Usage: (temporary permissions)
chmod **777**   rwxrwxrwx

### Read for User; Read for Group; Read for Others
Usage: Shared read-only files
chmod **440**   r--r--r--

### Read, execute for User; Read, execute for G; Read, execute for Others
Usage: Shared executables
chmod **550**   r-xr-x---

### Read, write, execute User; Read, execute Group; None Others
Usage: Restricted shared directories
chmod **750**   rwxr-x---

### Read, write for User; Read, write for Group; Read for Others
Usage: Collaborative files
chmod **664**   rw-rw-r--

## System Defaults

### Files:

**/etc/sudoers**        | root      | root      | -        | `440`
**/etc/passwd**         | root      | root      | `644`      | `644`
**/etc/shadow**         | root      | shadow    | `000`      | `640`
**/etc/ssh/ssh_config** | root      | root      | `644`      | `644`
**~/.ssh/id_rsa**       | user      | user      | `600`      | `600`
**~/.ssh/id_rsa.pub**   | user      | user      | `644`      | `644`
**~/.gnupg/**           | user      | user      | `700`      | `700`
**/usr/bin/**           | root      | root      | `755`      | `755`
**/var/www/**           | root      | www-data  | `775`      | `775`

### Directories:

**/usr/bin/**                  | root      | root      | `755`
**/var/www/**                  | root      | http      | `775`
**/var/spool/cron/**           | root      | crontab   | `755`
**/var/spool/cron/crontabs/**  | root      | crontab   | `1733`
**/etc/ssh/sshd_config**       | root      | root      | `600`
**/etc/hosts.allow**           | root      | root      | `644`
**/etc/hosts.deny**            | root      | root      | `644`
**/etc/profile**               | root      | root      | `644`
**/etc/bash.bashrc**           | root      | root      | `644`
**/var/log/**                  | root      | root      | `750`
**/usr/local/bin/**            | root      | root      | `755`
**$HOME**                      | user      | user      | `755`
**$HOME/.bashrc**              | user      | user      | `644`
**$HOME/.bash_profile**        | user      | user      | `644`
**$HOME/zsh/completions**      | user      | user      | `644`    # Applies to completion files
**/tmp**                       |           |           | `1777`

---

## Tips & Tricks

- Chmod all files recursively to 644(default):

     ```bash
     find ./ -type f -exec chmod 644 {} ;
     ```

- Handle Symbolic Links Appropriately:

   - Prevent unintended modifications by not following symbolic links:

     ```bash
     find "$path" -type d -exec chmod "$dir_perm" {} \; -o -type f -exec chmod "$file_perm" {} \;
     ```

- Crontab:

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

- Tmp:

     ```bash
     sudo chmod 1777 /tmp
     ```

- Polkit:

     ```bash
     sudo chmod 750 /etc/polkit-1/rules.d/
     ```

---

## Chmod Details

Uses a three-digit octal number to set permissions:

- **First digit**: Owner permissions
- **Second digit**: Group permissions
- **Third digit**: Others (world) permissions

Each digit is a sum of its component permissions:

- **4**: Read (`r`)
- **2**: Write (`w`)
- **1**: Execute (`x`)
- **0**: No permission

For example, `7` (4+2+1) grants read, write, and execute permissions.

## Special Permission Bits

In addition to the basic permissions, there are special bits that can modify how permissions are handled:

- **Setuid (`4xxx`)**: Executes a file with the file owner's permissions.
- **Setgid (`2xxx`)**: Executes a file with the group's permissions; new files inherit the group ID.
- **Sticky Bit (`1xxx`)**: Only the file owner or root can delete or modify files within the directory.

Example:

- **4755**: Setuid + `rwxr-xr-x`
- **2775**: Setgid + `rwxrwxr-x`
- **1755**: Sticky Bit + `rwxr-xr-x`

Use Cases:

- **Setuid**: Programs like `passwd` that require elevated privileges.
- **Setgid**: Shared directories where group collaboration is essential.
- **Sticky Bit**: `/tmp` directory to prevent users from deleting each other's files.

## Octal Permission Meaning

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
