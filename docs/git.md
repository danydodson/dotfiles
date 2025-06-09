# Git 🐙

## HTTPS

### Repository access via HTTPS

-   For HTTPS authentication, use the GitHub CLI use `gh auth login`

-   When HTTPS is desired, use `git clone --recursive https://github.com/user/repo.git`

> Please note that the GitHub CLI must be installed via `brew`. See the how the helper is invoked in [git config](/config/git/config).

## SSH

### Set up `~/.ssh`

```bash
# fix directory permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# fix all key permissions
chmod 600 ~/.ssh/*
chmod 600 ~/.ssh/*.pub

# fix special files permissions
chmod 644 ~/.ssh/known_hosts
chmod 600 ~/.ssh/authorized_keys
chmod 755 ~/.ssh/config
```

### Repository access via SSH

-   Add the machine's `id_rsa.pub` or `id_ed25519.pub` SSH key to GitHub.
-   Hook up 1Password with the ssh agent, see [1password agent.toml](/config/1Password/ssh/agent.toml).
-   When SSH is desired, use `git clone --recursive git@github.com:user/repo.git`.

### 1Password commit signing

-   Find the git commit signing key info in 1password and save as [.gitsecret](/.gitsecret).
-   This file is included by [git config](/config/git/config).
-   Also, edit [1password agent.toml](/config/1Password/ssh/agent.toml) to say something like:

    ```toml
    [[ssh-keys]]
    item = "<key name>"
    vault = "Workplace"
    account = "<account name>"
    ```

    ```toml
    [[ssh-keys]]
     item = "<key name>"
     vault = "Personal"
     account = "<account name>"
    ```

### Update gitconfig email

-   Review/update the email used in [git config](/config/git/config).
