# SSH Cheat Sheet

## Verify Existing SSH Key

### List All SSH Keys
```bash
ls -la ~/.ssh
```
- **Explanation:**
  - This command lists all files in the `~/.ssh` directory, including hidden files.
  - If you see files like `id_rsa`, `id_rsa.pub`, or `id_ed25519`, it means you already have SSH keys generated.
  - The `-la` option shows detailed information about each file, including permissions, owner, and group.

## Generate a New SSH Key

### Generate a New RSA SSH Key Pair
```bash
ssh-keygen -t rsa -b 4096 -C "01_dolor.loftier@icloud.com"
```
- **Explanation:**
  - The `-t rsa` flag specifies the type of key to create, which is RSA in this case.
  - The `-b 4096` flag specifies the bit length of the key. A length of 4096 bits is recommended for strong security.
  - The `-C` flag adds a comment in the key, typically an email address, which helps identify the key.

### Follow the Prompts
- **File Location:** You'll be prompted to enter a file in which to save the key. Press Enter to accept the default location (`~/.ssh/id_rsa`).
- **Passphrase:** You'll also be asked to enter a passphrase, which adds an additional layer of security. Press Enter to leave it empty if you don't want to use a passphrase.

## Copy Public Key

### Display the Public Key
```bash
cat ~/.ssh/id_rsa.pub
```
- **Explanation:**
  - This command outputs the contents of your public key to the terminal.
  - You can then copy this key to add it to remote servers or services like GitHub.

### Copy Public Key to Clipboard (Linux/macOS)
```bash
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
```
- **Explanation:**
  - This command copies the public key directly to your clipboard, making it easy to paste into a remote server or service.

### Automatically Copy Public Key to a Remote Server
```bash
ssh-copy-id user@remote_host
```
- **Explanation:**
  - This command installs your public key on the remote server, allowing you to log in without a password.
  - Replace `user` with your username on the remote server and `remote_host` with the server's address.

## Correct Permissions

### Set Correct Permissions for SSH Files
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```
- **Explanation:**
  - **`chmod 700 ~/.ssh`:** Sets the `.ssh` directory permissions so that only the owner can read, write, and execute files.
  - **`chmod 600 ~/.ssh/id_rsa`:** Sets the private key file (`id_rsa`) permissions so that only the owner can read and write it.
  - **`chmod 644 ~/.ssh/id_rsa.pub`:** Sets the public key file (`id_rsa.pub`) permissions so that the owner can read and write it, and others can only read it.
  
### Recursively Set Permissions for All Files in `.ssh`
```bash
chmod -R go= ~/.ssh
```
- **Explanation:**
  - The `-R` flag applies the permissions recursively to all files in the `.ssh` directory.
  - `go=` removes all permissions (read, write, execute) for "group" and "others," ensuring that only the file owner has access.

## Additional Considerations

### Test SSH Connection
```bash
ssh -T git@github.com
```
- **Explanation:**
  - This command tests your SSH connection to GitHub. If successful, you'll see a message like "Hi `username`! You've successfully authenticated."
  - Replace `git@github.com` with the appropriate user and host for other servers.

### Add SSH Key to SSH Agent (Optional)
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```
- **Explanation:**
  - The first command starts the SSH agent in the background.
  - The second command adds your private key to the SSH agent, allowing you to use the key without entering the passphrase every time.

### Adding Your SSH Key to GitHub
- **Steps:**
  1. Copy your public SSH key (`id_rsa.pub`).
  2. Go to your GitHub account.
  3. Navigate to **Settings > SSH and GPG keys**.
  4. Click **New SSH key**, paste your key, and give it a title.
  5. Save the key.

### Troubleshooting SSH Issues
- **Check SSH Agent:** 
  - Ensure the SSH agent is running by executing `eval "$(ssh-agent -s)"`.
- **Permissions:** 
  - Verify that the `.ssh` directory and files have the correct permissions, as incorrect permissions can lead to errors.
- **Verbose Mode:** 
  - Use `ssh -v user@remote_host` to see detailed logs if you're experiencing connection issues.
```
