#### code-server

- [code-server](https://github.com/coder/code-server) is an open-source alternative to codespaces.
- I set up code-server on a Linux cloud server. I prefer to use DigitalOcean, following their [recommended initial setup guide](https://www.digitalocean.com/docs/droplets/tutorials/recommended-setup/) for "droplets" (VMs):
  - Set up [SSH agent forwarding](https://docs.github.com/en/free-pro-team@latest/developers/overview/using-ssh-agent-forwarding) on local machine to avoid having to deposit SSH private keys on droplet
  - Add SSH public key when creating droplet
  - Add a user data script like _[linux-userdata.sh](scripts/linux-userdata.sh)_
- [Installation](https://github.com/coder/code-server/blob/v3.7.2/doc/install.md) and [setup](https://github.com/coder/code-server/blob/v3.7.2/doc/guide.md) on the server:

  ```sh
  curl -fsSL https://code-server.dev/install.sh | sh
  sudo systemctl enable --now code-server@$USER
  ```

- Server configuration file: note that `user-data-dir` must be an absolute path if running with the `systemctl` background service.

  ```yaml
  bind-addr: 127.0.0.1:8080
  auth: none
  password: false
  cert: false
  user-data-dir: /home/brendon/.dotfiles/vscode
  ```

- Local machine
  - Forward port from server by running `ssh -N -L 8080:127.0.0.1:8080 code-server` on the local machine.
  - Open http://localhost:8080 in a browser and you should see VSCode!
  - Multiple workspaces can be opened by passing the `?workspace=` query parameter in the URL. Each browser tab can have a workspace open.
  - Proxy ports back to local machine with the `/proxy` endpoint. For example, to hit an API endpoint running on port 1025 on the server, `curl :8080/proxy/1025`. As explained in the [VSCode docs](https://code.visualstudio.com/docs/containers/python-user-rights), if developing on Linux, note that non-root users may not be able to expose ports less than 1024. The port is set to `1025` in the debugger config for this reason.
- Extensions:
  - code-server has its own extension marketplace that is created by scraping GitHub.
  - You can also install extensions with the CLI: `code-server --install-extension`.
- Settings
  - If the shell doesn't look right: Command Palette -> Terminal: Select Default Shell
  - The browser may grab some VSCode keybindings. I prefer to use Safari, because it grabs the least shortcuts.
  - `code-server` can't be used as a Git editor, as far as I can tell. It can open text files from the command-line, but the `--wait` switch is not recognized.
  - The clipboard doesn't completely work. See [coder/code-server#1106](https://github.com/coder/code-server/issues/1106).
  - The font can't yet be customized directly. See [coder/code-server#1374](https://github.com/coder/code-server/issues/1374).
  - You can change the color theme, but you may need to re-select the theme each time you open a browser tab.
