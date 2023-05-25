You have to restart karabiner_console_user_server process by the following
command after you made a symlink in order to tell Karabiner-Elements that
the parent directory is changed.

```bash
launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
```