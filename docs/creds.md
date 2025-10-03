# Git 🐙

## HTTPS

### Repository access via HTTPS

- For HTTPS authentication, use the GitHub CLI use `gh auth login`

- When HTTPS is desired, use `git clone --recursive https://github.com/user/repo.git`

> Please note that the GitHub CLI must be installed via `brew`. See the how the helper is invoked in [git config](/config/git/config).

## SSH

---

#### Set up `~/.ssh`

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

#### Repository access via SSH

- Add the machine's `id_rsa.pub` or `id_ed25519.pub` SSH key to GitHub.
- Hook up 1Password with the ssh agent, see [1password agent.toml](/config/1Password/ssh/agent.toml).
- When SSH is desired, use `git clone --recursive git@github.com:user/repo.git`.

#### 1Password commit signing

- Find the git commit signing key info in 1password and save as [.gitsecret](/.gitsecret).
- This file is included by [git config](/config/git/config).
- Also, edit [1password agent.toml](/config/1Password/ssh/agent.toml) to say something like:

```toml
[[ssh-keys]]
item = "<key name>"
vault = "Workplace"
account = "<account name>"

[[ssh-keys]]
 item = "<key name>"
 vault = "Personal"
 account = "<account name>"
```

#### Update gitconfig email

Review/update the email used in [git config](/config/git/config).

---

### GPG 🔐

GPG is an implementation of [OpenPGP](https://www.openpgp.org).

#### Installation

- Install `gnupg`

  - macOS: _brew install gnupg_
  - Linux: _sudo apt-get install gnupg_
  - Manually: [GnuPG](https://www.gnupg.org/download/index.html)

- Install `pinentry`

  - macOS: `brew install` `pinentry` or `pinentry-mac` uses GUI Keychain app
  - Linux: `apt install pinentry`
  - Manually: On macOS, Apple's command-line tools (`xcode-select`) should have the build prerequisites. [Download](https://www.gnupg.org/download/index.html) `libgpg-error`, `libassuan`, and `pinentry`,

  then build from source and install in order (`libgpg-error`, then `libassuan`, then `pinentry`):

```sh
cd /path/to/libgpg-error
./configure; make; sudo make install

cd /path/to/libassuan
./configure; make; sudo make install

cd /path/to/pinentry
./configure; make; sudo make install
```

- Set the `pinentry` program:

  - edit _~/.gnupg/gpg-agent.conf_ `pinentry-program /opt/homebrew/bin/pinentry-tty`
  - The path apparently has to be absolute, so it may vary by system.
  - See the [GPG agent options docs](https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html) for more.
  - `pinentry-tty` allows plain-text password entry. `pinentry` may raise confusing "Screen or window too small" errors in some terminals.

- [Export the `GPG_TTY` environment variable](https://www.gnupg.org/documentation/manuals/gnupg/Agent-Examples.html): `export GPG_TTY=$(tty)` (can add to shell profile to automatically export). Note that this is not the same thing as `export GPG_TTY=$TTY`, which may raise cryptic `Inappropriate ioctl for device` errors.

- Ensure proper permissions are set on GPG config files:
  ```sh
  chmod 700 ~/.gnupg
  chmod 600 ~/.gnupg/gpg.conf
  ```
- See the [GPG configuration docs](https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration.html) for more.

#### GPG and YubiKey

Resources:

- [`gpg-card` docs](https://gnupg.org/documentation/manuals/gnupg/gpg_002dcard.html)
- [Yubico developers: PGP](https://developers.yubico.com/PGP/)
- [Yubico support: using your YubiKey with OpenPGP](https://support.yubico.com/hc/en-us/articles/360013790259-Using-Your-YubiKey-with-OpenPGP)
- [YubiKey Manager CLI (`ykman`) User Manual](https://docs.yubico.com/software/yubikey/tools/ykman/Using_the_ykman_CLI.html)
- [Okta developer blog: Developers guide to GPG and YubiKey](https://developer.okta.com/blog/2021/07/07/developers-guide-to-gpg)

A YubiKey has admin and non-admin OpenPGP PINs.

- Default OpenPGP admin PIN is 12345678.
- Default OpenPGP non-admin PIN is 123456.
- Change OpenPGP PINs with `gpg --change-pin` or `ykman openpgp access change-admin-pin`/`ykman openpgp access change-pin`.

To use a GPG key on a YubiKey with a new computer, plug in the YubiKey, check the status, and fetch the public keys.

```text
~
❯ gpg --card-status

~
❯ gpg --card-edit

gpg/card> admin
Admin commands are allowed

gpg/card> url
URL to retrieve public key: https://github.com/<YOUR_GITHUB_USERNAME>.gpg

gpg/card> fetch

gpg/card> quit
```

To move a GPG key from a computer to a YubiKey, use `gpg --edit-key` followed by `keytocard`. The `keytocard` command is repeated for each "where to store the key" option. After the two `keytocard` commands, there may be confusing output regarding whether or not to "save" your changes, including `Note: the local copy of the secret key will only be deleted with "save".` As recommended in [Yubico support: using your YubiKey with OpenPGP](https://support.yubico.com/hc/en-us/articles/360013790259-Using-Your-YubiKey-with-OpenPGP), entering "no" at these prompts will avoid deleting the GPG key from the computer (but will still save it to the YubiKey).

```text
~
❯ gpg --edit-key <KEY_ID>

gpg> keytocard
Really move the primary key? (y/N) y
Please select where to store the key:
   (1) Signature key
   (3) Authentication key
Your selection? 1
gpg: pinentry launched (11284 tty 1.2.1 /dev/ttys004 xterm-kitty - 20620/501/4 501/20 0)
Please enter your passphrase, so that the secret key can be unlocked for this session
Passphrase:
gpg: pinentry launched (11285 tty 1.2.1 /dev/ttys004 xterm-kitty - 20620/501/4 501/20 0)
Please enter the Admin PIN

Number: 12 345 678
Holder:
Admin PIN:
gpg: pinentry launched (11287 tty 1.2.1 /dev/ttys004 xterm-kitty - 20620/501/4 501/20 0)
Please enter the Admin PIN

Number: 12 345 678
Holder:
Admin PIN:

sec  ed25519/16digit_PGPkeyid
     created: 1900-01-01  expires: never       usage: SC
     trust: unknown       validity: unknown
ssb  cv25519/16digit_PGPkeyid
     created: 1900-01-01  expires: never       usage: E
[ unknown] (1). you <you@example.com>

Note: the local copy of the secret key will only be deleted with "save".

gpg> keytocard
Really move the primary key? (y/N) y
Please select where to store the key:
   (1) Signature key
   (3) Authentication key
Your selection? 3

gpg: pinentry launched (11284 tty 1.2.1 /dev/ttys004 xterm-kitty - 20620/501/4 501/20 0)
Please enter your passphrase, so that the secret key can be unlocked for this session
Passphrase:
gpg: pinentry launched (11285 tty 1.2.1 /dev/ttys004 xterm-kitty - 20620/501/4 501/20 0)
Please enter the Admin PIN

Number: 12 345 678
Holder:
Admin PIN:
gpg: pinentry launched (11287 tty 1.2.1 /dev/ttys004 xterm-kitty - 20620/501/4 501/20 0)
Please enter the Admin PIN

Number: 12 345 678
Holder:
Admin PIN:

sec  ed25519/16digit_PGPkeyid
     created: 1900-01-01  expires: never       usage: SC
     trust: unknown       validity: unknown
ssb  cv25519/16digit_PGPkeyid
     created: 1900-01-01  expires: never       usage: E
[ unknown] (1). you <you@example.com>

Note: the local copy of the secret key will only be deleted with "save".

gpg> Q
Save changes? (y/N) N
Quit without saving? (y/N) y
```

#### GPG key generation

- Run `gpg --full-generate-key` from the command line to generate a key. Respond to the command-line prompts. The maximum key size of `4096` is recommended.
- View keys with `gpg --list-secret-keys`.
- Run `gpg --send-keys <keynumber>` to share the public key with the GPG database. It takes about 10 minutes for the key to show up in the GPG database.

#### Key import and export

- Import a GPG key from a file: `gpg --import /path/to/privatekey.asc`
- Export your GPG public key:
  - Copy to clipboard (for pasting into GitHub/GitLab): `gpg --armor --export | pbcopy`
  - Export to a file: `gpg --armor --export > public.gpg`

#### Sending messages

- Locate another user's key in the global database with `gpg --search-keys <email>`.
- Encrypting communications
  - Encrypt a message with `echo "Hello, World!" | gpg --encrypt --armor --recipient "<email>"`. Optionally, save the encrypted message in a .gpg file.
  - If the message was saved in a file, send the file over email, Slack, or any other medium.
  - Decrypt the message with `gpg --decrypt`.
    - If copying the encrypted text directly, include it in quotes: `echo "BIG LONG GPG STRING" | gpg --decrypt`.
    - If reading a file, include the filename when decrypting: `gpg --decrypt message.gpg`.
    - Decrypted output can be autosaved to a new file: `gpg --decrypt message.gpg --output file.txt`.

#### Signing Git commits with GPG

Note that SSH can also be used to sign Git commits. See the [SSH section](#ssh) for further details.

- See [Pro Git: Signing your work](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work).
- Install and configure `pinentry` as described above.
- Configure Git to use GPG and your key for commits, using _.gitconfig_:
  - Set `signingkey`: `git config --global user.signingkey 16digit_PGPkeyid` the 16 digit PGP key id is the partial 16 digit number listed on the `sec` line).
    ```ini
    [user]
    name = your name
    email = you@email.com
    signingkey = 16digit_PGPkeyid
    ```
  - Turn on `gpgsign`:
    ```ini
    [commit]
    gpgsign = true
    ```

#### General

- Start the agent: `gpg-connect-agent /bye`
- Reload the agent configuration: `gpg-connect-agent reloadagent /bye`
- Stop the agent: `gpgconf --kill gpg-agent` or `gpgconf --kill all`. See the [GPG docs on invoking `gpg-agent`](https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html).
- Verify GPG signing capabilities: `echo "test" | gpg --clearsign`
- Trust GPG keys using the GPG TTY interface:
  - If you see `gpg: WARNING: This key is not certified with a trusted signature!` when examining signed Git commits with `git log --show-signature`, you may want to trust the keys.
  - Enter the GPG key editor from the command line with `gpg --edit-key <PGPkeyid>`.
  - Set trust level for the key by typing `trust`, hitting enter, and entering a trust level.
  - See the [GPG docs](https://www.gnupg.org/gph/en/manual/x334.html) for more info.
- [GitHub GPG instructions](https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification)
- [GitLab GPG instructions](https://gitlab.com/help/user/project/repository/gpg_signed_commits/index.md)
- If working on a server, you can use [ssh agent forwarding](https://docs.github.com/en/free-pro-team@latest/developers/overview/using-ssh-agent-forwarding) to access your SSH and GPG keys without having to copy them.
