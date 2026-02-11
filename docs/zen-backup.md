# Zen Browser Backup and Restore Script

A comprehensive backup and restore solution for Zen Browser on macOS. This script safely backs up all your browser data including bookmarks, extensions, themes, session data, and preferences.

## Features

- **Complete Profile Backup**: Backs up all essential Zen Browser data
- **Smart Profile Detection**: Automatically finds and uses your active Zen profile
- **Safe Restore Process**: Creates a backup of your current profile before restoring
- **Cross-Profile Support**: Handles multiple profiles and selects the most recently used one
- **Space-Safe Paths**: Properly handles profile names with spaces
- **Comprehensive Coverage**: Backs up bookmarks, extensions, themes, sessions, preferences, and more

## What Gets Backed Up

- ✅ **User Preferences** (`prefs.js`) - All your browser settings
- ✅ **Bookmarks & History** (`places.sqlite`) - Your saved bookmarks and browsing history
- ✅ **Session Data** (`sessionstore.jsonlz4`) - Open tabs and pinned tabs
- ✅ **Extensions** (`extensions/`, `*.xpi`) - All installed add-ons and their data
- ✅ **Custom Themes & Mods** (`chrome/`, `zen-themes.json`) - Your custom CSS and theme configurations
- ✅ **Containers** (`containers.json`) - Container tab settings
- ✅ **Cookies & Site Data** (`cookies.sqlite`, `storage/`) - Login sessions and site preferences
- ✅ **Certificates** (`cert9.db`) - Security certificates
- ✅ **Form Data** (`formhistory.sqlite`) - Saved form information
- ✅ **Site Permissions** (`permissions.sqlite`) - Website permissions and preferences

## Installation

1. **Download the script**:
   ```bash
   curl -O https://raw.githubusercontent.com/Sanjay15693/zen-browser-backup/refs/heads/main/zen_backup.sh
   # Or download manually and save as zen_backup.sh
   ```

2. **Make it executable**:
   ```bash
   chmod +x zen_backup.sh
   ```

3. **Verify Zen Browser is installed**:
   - Make sure you have Zen Browser installed and have run it at least once
   - The script looks for profiles in: `~/Library/Application Support/zen/Profiles`

## Usage

### Basic Commands

```bash
# Create a backup with automatic timestamp
./zen_backup.sh backup

# Create a backup with custom name
./zen_backup.sh backup my-setup-2024

# List all available backups
./zen_backup.sh list

# Restore from a backup
./zen_backup.sh restore my-setup-2024

# Show help
./zen_backup.sh help
```

### Detailed Examples

#### Creating Backups

```bash
# Quick backup with auto-generated name
./zen_backup.sh backup
# Creates: zen-backup-20241216-143022

# Backup before major changes
./zen_backup.sh backup before-extension-cleanup

# Backup your perfect setup
./zen_backup.sh backup my-perfect-zen-setup
```

#### Restoring Backups

```bash
# First, see what backups are available
./zen_backup.sh list

# Restore a specific backup (Zen must be closed first)
./zen_backup.sh restore my-perfect-zen-setup
```

## Important Notes

### Before Restoring
- **⚠️ Close Zen Browser completely** before running restore
- The script will automatically create a backup of your current profile before restoring
- These safety backups are named `pre-restore-YYYYMMDD-HHMMSS`

### Backup Locations
- **Backups are stored in**: `~/Documents/ZenBackups/`
- **Each backup includes**: A `backup_info.txt` file with metadata
- **Safety backups**: Created automatically before each restore operation

### Multiple Profiles
If you have multiple Zen profiles, the script will:
1. Automatically detect all profiles
2. Choose the most recently used/active profile
3. Prioritize profiles with actual browser data over empty ones

## Troubleshooting

### Common Issues

#### "No Zen profile found"
```bash
Error: No Zen profile found in /Users/username/Library/Application Support/zen/Profiles
```
**Solutions:**
- Make sure Zen Browser is installed
- Run Zen Browser at least once to create a profile
- Check if Zen is installed in a different location

#### "Please close Zen browser before restoring"
```bash
Error: Please close Zen browser before restoring!
```
**Solutions:**
- Completely quit Zen Browser (Cmd+Q)
- Check Activity Monitor for any remaining Zen processes
- Wait a few seconds after closing, then try again

#### "Cannot access profile directory"
```bash
Error: Cannot access profile directory: /path/to/profile
```
**Solutions:**
- Check if the profile directory exists
- Verify you have read permissions
- Try running the script with `sudo` if permission issues persist

#### Backup seems incomplete
**Check:**
- Look at the script output - it shows which files are "Skipping (not found)"
- Some files (like `places.sqlite-shm`) may not exist if Zen isn't running
- Verify your Zen profile has the expected data

### Manual Profile Selection

If the automatic profile detection isn't working correctly, you can modify the script or check your profiles manually:

```bash
# List all Zen profiles
ls -la "$HOME/Library/Application Support/zen/Profiles"

# Check which profile has recent activity
ls -la "$HOME/Library/Application Support/zen/Profiles/"*/places.sqlite
```

## Advanced Usage

### Scripting and Automation

```bash
# Create daily backups (add to cron/launchd)
./zen_backup.sh backup "daily-$(date +%Y%m%d)"

# Backup before system updates
./zen_backup.sh backup "pre-system-update-$(date +%Y%m%d)"
```

### Backup Management

```bash
# List backups with details
ls -la ~/Documents/ZenBackups/

# Check backup contents
ls -la ~/Documents/ZenBackups/my-backup-name/

# View backup metadata
cat ~/Documents/ZenBackups/my-backup-name/backup_info.txt
```

## Safety Features

- **Automatic Safety Backups**: Before each restore, your current profile is automatically backed up
- **Non-Destructive**: Original backups are never modified during restore operations  
- **Verification**: Script verifies backup and profile directories exist before proceeding
- **Process Checking**: Prevents restore operations while Zen is running
- **Error Handling**: Comprehensive error checking with helpful messages

## File Structure

```
~/Documents/ZenBackups/
├── my-zen-setup/
│   ├── backup_info.txt          # Backup metadata
│   ├── prefs.js                 # User preferences
│   ├── places.sqlite            # Bookmarks & history
│   ├── sessionstore.jsonlz4     # Session data
│   ├── zen-themes.json          # Theme configuration
│   ├── extensions/              # Extension data
│   ├── chrome/                  # Custom CSS
│   └── [other profile files]
└── pre-restore-20241216-143022/ # Safety backup
    └── [current profile backup]
```

## Contributing

Feel free to submit issues, feature requests, or pull requests to improve this script.

## License

This script is provided as-is for personal use. Please backup your data regularly and test restores to ensure they work for your setup.
