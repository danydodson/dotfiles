# XDG SPECIFICATIONS

### Variable Definitions:

1. **$XDG_DATA_HOME**: Defines the base directory relative to which user-specific data files should be stored. If $XDG_DATA_HOME is either not set or empty, a default equal to $HOME/.local/share should be used.

2. **$XDG_CONFIG_HOME**: Single base directory relative to which user-specific configuration files should be written. This directory is defined by the environment variable

3.  **$XDG_STATE_HOME**: Single base directory relative to which user-specific state data should be written.

4. **$XDG_DATA_DIRS**: Set of preference ordered base directories relative to which data files should be searched.

5. **$XDG_CONFIG_DIRS**: Set of preference ordered base directories relative to which configuration files should be searched.

6. **$XDG_CACHE_HOME**: Single base directory relative to which user-specific non-essential (cached) data should be written.

7. **$XDG_RUNTIME_DIR**: Single base directory relative to which user-specific runtime files and other file objects should be placed.

---

### Variable Locations:

1. **$XDG_DATA_HOME** = `$HOME/.local/share`

2. **$XDG_CONFIG_HOME** = `$HOME/.config`

3. **$XDG_STATE_HOME** = `$HOME/.local/state`

4. **$XDG_DATA_DIRS** = `/usr/local/share/:/usr/share/`

* *Mkdir if not exist*:
```bash
[ -z "$XDG_DATA_DIRS" ] && export XDG_DATA_DIRS="/usr/local/share:/usr/share"
```

5. **$XDG_CONFIG_DIRS** = `/etc/xdg`

6. **$XDG_CACHE_HOME** = `$HOME/.cache`

7. **$XDG_RUNTIME_DIR** = `/run/user/$(id -u)`

    * *Dir must be owned by user, must be only one w read and write access and chmod 0700*
    * *Dir must continue to exist from user login to user logout and not removed in between.*
    * *Ensure files arent removed: access time timestamp modified every 6 hours of monotonic time or the `sticky` bit should be set on the file.*
    * *Must be created upon user login*
    * *Must be removed on user logout*
    * *Files must not survive reboot or a full logout/login cycle.*

* *Mkdir if not exist*:
```bash
 if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi

if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    mkdir -p "$XDG_RUNTIME_DIR"
fi
```

---

### Config File Compliance:

**Git**
    - Move `.gitconfig` from `~/.gitconfig` to `$XDG_CONFIG_HOME/git/config`

