#!/usr/bin/env bash
# shellcheck disable=all
# File: ytdl
# Author: 4ndr0666
# Edited: 11-3-24
# ytdl: A comprehensive Bash script for downloading videos and playlists using yt-dlp.

# =================================== // YTDL //
# --- // Create config:
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/yt-dlp"
CONFIG_FILE="$CONFIG_DIR/yt-dlp.conf"

setup_config() {
  if [ ! -d "$CONFIG_DIR" ]; then
    mkdir -p "$CONFIG_DIR"
    echo "Created configuration directory at $CONFIG_DIR"
  fi

  if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating configuration file at $CONFIG_FILE"
    cat <<EOL > "$CONFIG_FILE"
# yt-dlp Configuration File

# External Downloader Arguments (aria2c)
downloader_args="-c -j 4 -x 4 -s 4 -k 2M"

# Log File Path
log_file="$HOME/yt-dlp.log"

# Retry Mechanism
retry_count=3
retry_backoff=5

# Subtitle Preferences
sub_lang="en"
write_sub=true

# Encrypted Cookie Directory
COOKIEDIR="$CONFIG_DIR/cookies"

# Encrypted Cookie File Path
cookie_file="$COOKIEDIR/cookies.txt.gpg"
EOL
    echo "Configuration file created. Please review and modify it as needed."
  fi
}

# --- // Load config: 
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
  echo "Configuration loaded from $CONFIG_FILE"
else
  setup_config
  source "$CONFIG_FILE"
fi

# --- // Defaults: 
downloader_args="${downloader_args:-"-c -j 3 -x 3 -s 3 -k 1M"}"
log_file="${log_file:-"$HOME/yt-dlp.log"}"
retry_count="${retry_count:-3}"
retry_backoff="${retry_backoff:-5}"
sub_lang="${sub_lang:-en}"
write_sub="${write_sub:-false}"
COOKIEDIR="${COOKIEDIR:-"$CONFIG_DIR/cookies"}"
cookie_file="${cookie_file:-"$COOKIEDIR/cookies.txt.gpg"}"

# --- // Log:
log_message() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$log_file"
}

# --- // Modular error handler:
handle_error() {
  local exit_code="$1"
  local action="$2"
  case "$exit_code" in
    1)
      echo "General error during $action."
      log_message "General error during $action."
      ;;
    2)
      echo "Misuse of shell builtins during $action."
      log_message "Misuse of shell builtins during $action."
      ;;
    3)
      echo "Command invoked cannot execute during $action."
      log_message "Command execution failure during $action."
      ;;
    4)
      echo "Command not found during $action."
      log_message "Command not found during $action."
      ;;
    255)
      echo "Exit status out of range during $action."
      log_message "Exit status out of range during $action."
      ;;
    *)
      echo "An unknown error occurred during $action."
      log_message "Unknown error (code $exit_code) during $action."
      ;;
  esac
}

# --- // Deps:
check_dependencies() {
  local dependencies=("yt-dlp" "aria2c" "gpg" "logrotate")
  local missing=()
  
  for cmd in "${dependencies[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
      missing+=("$cmd")
    fi
  done
  
  if [ ${#missing[@]} -ne 0 ]; then
    log_message "Missing dependencies: ${missing[*]}"
    echo "The following dependencies are missing: ${missing[*]}"
    read -p "Would you like to install them now? [Y/n]: " response
    response=${response,,} # tolower
    if [[ "$response" =~ ^(yes|y| ) ]] || [[ -z "$response" ]]; then
      sudo pacman -S --noconfirm "${missing[@]}"
      if [ $? -eq 0 ]; then
        log_message "Successfully installed dependencies: ${missing[*]}"
        echo "Dependencies installed successfully."
      else
        log_message "Failed to install dependencies: ${missing[*]}"
        echo "Failed to install dependencies. Please install them manually."
        return 1
      fi
    else
      echo "Cannot proceed without installing dependencies."
      return 1
    fi
  fi
}

retry_command() {
  local cmd="$1"
  local retries="$2"
  local backoff="$3"
  local count=0

  until eval "$cmd"; do
    exit_code=$?
    count=$((count + 1))
    if [ "$count" -le "$retries" ]; then
      echo "Command failed with exit code $exit_code. Retrying in $backoff seconds... ($count/$retries)"
      log_message "Command failed with exit code $exit_code. Retrying in $backoff seconds... ($count/$retries)"
      sleep "$backoff"
      backoff=$((backoff * 2)) # Exponential backoff
    else
      echo "Command failed after $retries attempts."
      log_message "Command failed after $retries attempts."
      handle_error "$exit_code" "command execution after retries"
      return 1
    fi
  done
}

# --- // Cookies:
encrypt_cookies() {
  local cookie_path="$1"
  if [ -f "$cookie_path" ]; then
    gpg --symmetric --cipher-algo AES256 "$cookie_path"
    if [ $? -eq 0 ]; then
      log_message "Successfully encrypted cookie file: $cookie_path"
      rm -f "$cookie_path" # Remove the unencrypted file
      echo "Cookie file encrypted successfully at $cookie_path.gpg"
    else
      echo "Failed to encrypt cookie file."
      log_message "Encryption failed for cookie file: $cookie_path"
      return 1
    fi
  else
    echo "Cookie file does not exist: $cookie_path"
    log_message "Attempted to encrypt non-existent cookie file: $cookie_path"
    return 1
  fi
}

decrypt_cookies() {
  local encrypted_cookie_path="$1"
  local decrypted_cookie_path="/tmp/cookies_decrypted.txt"
  if [ -f "$encrypted_cookie_path" ]; then
    gpg --decrypt --output "$decrypted_cookie_path" "$encrypted_cookie_path"
    if [ $? -eq 0 ]; then
      log_message "Successfully decrypted cookie file: $encrypted_cookie_path to $decrypted_cookie_path"
      echo "$decrypted_cookie_path"
    else
      echo "Failed to decrypt cookie file."
      log_message "Decryption failed for cookie file: $encrypted_cookie_path"
      return 1
    fi
  else
    echo "Encrypted cookie file does not exist: $encrypted_cookie_path"
    log_message "Attempted to decrypt non-existent cookie file: $encrypted_cookie_path"
    return 1
  fi
}

add_cookies() {
  echo "Starting the cookie addition process."
  
  # Ensure the cookie directory exists
  if [ ! -d "$COOKIEDIR" ]; then
    mkdir -p "$COOKIEDIR"
    echo "Created cookie directory at $COOKIEDIR"
    log_message "Created cookie directory at $COOKIEDIR"
  fi

  # Check if a cookie file already exists
  if [ -f "$cookie_file" ]; then
    read -p "A cookie file already exists at $cookie_file. Do you want to overwrite it? [Y/n]: " overwrite
    overwrite=${overwrite,,} # tolower
    if [[ "$overwrite" =~ ^(no|n)$ ]]; then
      echo "Cookie addition aborted."
      log_message "Cookie addition aborted by the user."
      return 0
    fi
  fi

  # Prompt user to choose input method
  echo "Choose how to input your cookies:"
  echo "1. Paste cookies directly into the terminal."
  echo "2. Open a text editor to input cookies."
  read -p "Enter your choice [1/2]: " choice

  case "$choice" in
    1)
      echo "Please paste your cookies below. Press Ctrl+D when done."
      # Read multi-line input until EOF
      cat > "/tmp/cookies_pasted.txt"
      if [ $? -ne 0 ]; then
        echo "Failed to read cookies from terminal."
        log_message "Failed to read cookies from terminal."
        return 1
      fi
      ;;
    2)
      # Open the default editor to input cookies
      TEMP_COOKIE="/tmp/cookies_editor.txt"
      ${EDITOR:-nano} "$TEMP_COOKIE"
      if [ $? -ne 0 ]; then
        echo "Failed to open text editor."
        log_message "Failed to open text editor for cookies."
        return 1
      fi
      if [ ! -s "$TEMP_COOKIE" ]; then
        echo "No cookies were entered."
        log_message "No cookies were entered in the text editor."
        rm -f "$TEMP_COOKIE"
        return 1
      fi
      cp "$TEMP_COOKIE" "/tmp/cookies_pasted.txt"
      rm -f "$TEMP_COOKIE"
      ;;
    *)
      echo "Invalid choice. Cookie addition aborted."
      log_message "Invalid choice during cookie addition. Aborted."
      return 1
      ;;
  esac

  # Encrypt the pasted cookies
  encrypt_cookies "/tmp/cookies_pasted.txt"
  if [ $? -ne 0 ]; then
    echo "Failed to encrypt and save cookies."
    log_message "Failed to encrypt and save cookies."
    rm -f "/tmp/cookies_pasted.txt"
    return 1
  fi

  # Move the encrypted cookies to the COOKIEDIR
  mv "/tmp/cookies_pasted.txt.gpg" "$cookie_file"
  if [ $? -eq 0 ]; then
    echo "Cookies have been successfully added and encrypted at $cookie_file."
    log_message "Cookies have been successfully added and encrypted at $cookie_file."
  else
    echo "Failed to move encrypted cookies to $cookie_file."
    log_message "Failed to move encrypted cookies to $cookie_file."
    return 1
  fi
}

# --- // Yt-dlp:
ytdl() {
  if [[ "$1" == "--help" ]]; then
    ytdl_help
    return 0
  fi

  local url="$1"

  check_dependencies || return 1

  if [[ -z "$url" ]]; then
    echo "Usage: ytdl <URL>"
    return 1
  fi

  # Validate URL format
  if [[ ! "$url" =~ ^https?:// ]]; then
    echo "Invalid URL provided."
    log_message "Invalid URL: $url"
    return 1
  fi

  # Handle cookies automatically
  if [ -f "$cookie_file" ]; then
    decrypted_cookies=$(decrypt_cookies "$cookie_file")
    if [ $? -ne 0 ]; then
      echo "Failed to decrypt cookie file. Proceeding without cookies."
      log_message "Failed to decrypt cookie file: $cookie_file. Proceeding without cookies."
      COOKIE_FLAG=""
    else
      COOKIE_FLAG="--cookies \"$decrypted_cookies\""
    fi
  else
    COOKIE_FLAG=""
  fi

  # Handle subtitle options
  if [ "$write_sub" = true ]; then
    SUB_FLAG="--write-sub --sub-lang \"$sub_lang\""
  else
    SUB_FLAG=""
  fi

  log_message "Starting download for URL: $url"

  # Construct yt-dlp command with aria2c
  CMD="yt-dlp --add-metadata \
         --embed-metadata \
         --external-downloader aria2c \
         --external-downloader-args \"$downloader_args\" \
         -f \"bestvideo+bestaudio/best\" \
         --no-playlist \
         --no-mtime \
         $SUB_FLAG \
         $COOKIE_FLAG \
         \"$url\""

  # Execute command with retries
  retry_command "$CMD" "$retry_count" "$retry_backoff"

  if [ $? -eq 0 ]; then
    echo "Download completed successfully."
    log_message "Download successful for URL: $url"
  else
    echo "Download failed after retries. Attempting fallback without external downloader."
    log_message "Download failed for URL: $url. Attempting fallback."

    # Construct fallback yt-dlp command without aria2c
    CMD_FALLBACK="yt-dlp --add-metadata \
                   --embed-metadata \
                   -f \"bestvideo+bestaudio/best\" \
                   --no-playlist \
                   --no-mtime \
                   $SUB_FLAG \
                   $COOKIE_FLAG \
                   \"$url\""

    # Execute fallback command with retries
    retry_command "$CMD_FALLBACK" "$retry_count" "$retry_backoff"

    if [ $? -eq 0 ]; then
      echo "Download completed successfully using fallback method."
      log_message "Download successful for URL: $url using fallback method."
    else
      echo "Download failed using fallback method. Check $log_file for details."
      log_message "Download failed for URL: $url using fallback method."
      [ -n "$decrypted_cookies" ] && rm -f "$decrypted_cookies"
      return 1
    fi
  fi

  # Clean up decrypted cookies
  [ -n "$decrypted_cookies" ] && rm -f "$decrypted_cookies"
}

# --- // Yt-dlp --list-formats: 
ytf() {
  if [[ "$1" == "--help" ]]; then
    ytf_help
    return 0
  fi

  local url="$1"

  check_dependencies || return 1

  if [[ -z "$url" ]]; then
    echo "Usage: ytf <URL>"
    return 1
  fi

  # Validate URL format
  if [[ ! "$url" =~ ^https?:// ]]; then
    echo "Invalid URL provided."
    log_message "Invalid URL for format listing: $url"
    return 1
  fi

  # Handle cookies automatically
  if [ -f "$cookie_file" ]; then
    decrypted_cookies=$(decrypt_cookies "$cookie_file")
    if [ $? -ne 0 ]; then
      echo "Failed to decrypt cookie file. Proceeding without cookies."
      log_message "Failed to decrypt cookie file: $cookie_file. Proceeding without cookies."
      COOKIE_FLAG=""
    else
      COOKIE_FLAG="--cookies \"$decrypted_cookies\""
    fi
  else
    COOKIE_FLAG=""
  fi

  log_message "Listing formats for URL: $url"

  # Construct yt-dlp command
  CMD="yt-dlp --list-formats $COOKIE_FLAG \"$url\""

  # Execute command with retries
  retry_command "$CMD" "$retry_count" "$retry_backoff"

  if [ $? -eq 0 ]; then
    log_message "Successfully listed formats for URL: $url"
  else
    echo "Failed to list formats after retries. Attempting fallback without cookies."
    log_message "Failed to list formats for URL: $url. Attempting fallback."

    # Construct fallback yt-dlp command without cookies
    CMD_FALLBACK="yt-dlp --list-formats \"$url\""

    # Execute fallback command with retries
    retry_command "$CMD_FALLBACK" "$retry_count" "$retry_backoff"

    if [ $? -eq 0 ]; then
      log_message "Successfully listed formats for URL: $url using fallback method."
    else
      echo "Failed to list formats using fallback method. Check $log_file for details."
      log_message "Failed to list formats for URL: $url using fallback method."
      [ -n "$decrypted_cookies" ] && rm -f "/tmp/cookies_decrypted.txt"
      return 1
    fi
  fi

  # Clean up decrypted cookies
  [ -n "$decrypted_cookies" ] && rm -f "/tmp/cookies_decrypted.txt"
}

# --- // Yt-dlp --yes-playlist: 
ytp() {
  if [[ "$1" == "--help" ]]; then
    ytp_help
    return 0
  fi

  local playlist_url="$1"

  check_dependencies || return 1

  if [[ -z "$playlist_url" ]]; then
    echo "Usage: ytp <Playlist URL>"
    return 1
  fi

  # Validate URL format
  if [[ ! "$playlist_url" =~ ^https?:// ]]; then
    echo "Invalid Playlist URL provided."
    log_message "Invalid Playlist URL: $playlist_url"
    return 1
  fi

  # Handle cookies automatically
  if [ -f "$cookie_file" ]; then
    decrypted_cookies=$(decrypt_cookies "$cookie_file")
    if [ $? -ne 0 ]; then
      echo "Failed to decrypt cookie file. Proceeding without cookies."
      log_message "Failed to decrypt cookie file: $cookie_file. Proceeding without cookies."
      COOKIE_FLAG=""
    else
      COOKIE_FLAG="--cookies \"$decrypted_cookies\""
    fi
  else
    COOKIE_FLAG=""
  fi

  # Handle subtitle options
  if [ "$write_sub" = true ]; then
    SUB_FLAG="--write-sub --sub-lang \"$sub_lang\""
  else
    SUB_FLAG=""
  fi

  log_message "Starting playlist download for URL: $playlist_url"

  # Construct yt-dlp command with aria2c
  CMD="yt-dlp --add-metadata \
         --embed-metadata \
         --external-downloader aria2c \
         --external-downloader-args \"$downloader_args\" \
         -f \"bestvideo+bestaudio/best\" \
         --yes-playlist \
         --write-playlist-metafiles \
         --concat-playlist always \
         $SUB_FLAG \
         $COOKIE_FLAG \
         \"$playlist_url\""

  # Execute command with retries
  retry_command "$CMD" "$retry_count" "$retry_backoff"

  if [ $? -eq 0 ]; then
    echo "Playlist downloaded successfully."
    log_message "Playlist download successful for URL: $playlist_url"
  else
    echo "Playlist download failed after retries. Attempting fallback without external downloader."
    log_message "Playlist download failed for URL: $playlist_url. Attempting fallback."

    # Construct fallback yt-dlp command without aria2c
    CMD_FALLBACK="yt-dlp --add-metadata \
                   --embed-metadata \
                   -f \"bestvideo+bestaudio/best\" \
                   --yes-playlist \
                   --write-playlist-metafiles \
                   --concat-playlist always \
                   $SUB_FLAG \
                   $COOKIE_FLAG \
                   \"$playlist_url\""

    # Execute fallback command with retries
    retry_command "$CMD_FALLBACK" "$retry_count" "$retry_backoff"

    if [ $? -eq 0 ]; then
      echo "Playlist downloaded successfully using fallback method."
      log_message "Playlist download successful for URL: $playlist_url using fallback method."
    else
      echo "Playlist download failed using fallback method. Check $log_file for details."
      log_message "Playlist download failed for URL: $playlist_url using fallback method."
      [ -n "$decrypted_cookies" ] && rm -f "$decrypted_cookies"
      return 1
    fi
  fi

  # Clean up decrypted cookies
  [ -n "$decrypted_cookies" ] && rm -f "$decrypted_cookies"
}

# --- // Help: 
ytdl_help() {
  echo "Usage: ytdl <URL>"
  echo ""
  echo "Description:"
  echo "  Downloads a single video with enhanced settings and security."
  echo ""
  echo "Parameters:"
  echo "  <URL>                    The URL of the video to download."
  echo ""
  echo "Options:"
  echo "  --help                   Display this help message."
  echo ""
  echo "Commands:"
  echo "  -c            Add or update cookies by pasting them or using a text editor."
  echo ""
  echo "Examples:"
  echo "  ytdl \"https://www.youtube.com/watch?v=example\""
}

ytf_help() {
  echo "Usage: ytf <URL>"
  echo ""
  echo "Description:"
  echo "  Lists all available formats for a given video URL."
  echo ""
  echo "Parameters:"
  echo "  <URL>                    The URL of the video to list formats for."
  echo ""
  echo "Options:"
  echo "  --help                   Display this help message."
  echo ""
  echo "Commands:"
  echo "  -c             Add or update cookies by pasting them or using a text editor."
  echo ""
  echo "Examples:"
  echo "  ytf \"https://www.youtube.com/watch?v=example\""
}

ytp_help() {
  echo "Usage: ytp <Playlist URL>"
  echo ""
  echo "Description:"
  echo "  Downloads an entire playlist with enhanced settings and security."
  echo ""
  echo "Parameters:"
  echo "  <Playlist URL>           The URL of the playlist to download."
  echo ""
  echo "Options:"
  echo "  --help                   Display this help message."
  echo ""
  echo "Commands:"
  echo "  -c             Add or update cookies by pasting them or using a text editor."
  echo ""
  echo "Examples:"
  echo "  ytp \"https://www.youtube.com/playlist?list=example\""
}

# ====================================== // MAIN ENTRY POINT //
display_general_help() {
  echo "yt-dlp.sh: A comprehensive Bash script for downloading videos and playlists using yt-dlp."
  echo ""
  echo "Available Commands:"
  echo "  ytdl            Download a single video."
  echo "  ytf             List available formats for a video."
  echo "  ytp             Download an entire playlist."
  echo "  -c     Add or update cookies."
  echo ""
  echo "Use '<command> --help' for more information on each command."
}

# Function to display usage for add-cookies
add_cookies_help() {
  echo "Usage: -c"
  echo ""
  echo "Description:"
  echo "  Adds or updates the encrypted cookie file by allowing you to paste cookies directly or edit them in a text editor."
  echo ""
  echo "Options:"
  echo "  --help          Display this help message."
  echo ""
  echo "Examples:"
  echo "  -c"
}

# If no arguments are provided, display a general help message
if [[ $# -eq 0 ]]; then
  display_general_help
  exit 0
fi

# Dispatch based on the first argument
case "$1" in
  ytdl)
    shift
    ytdl "$@"
    ;;
  ytf)
    shift
    ytf "$@"
    ;;
  ytp)
    shift
    ytp "$@"
    ;;
  -c)
    if [[ "$2" == "--help" ]]; then
      add_cookies_help
      exit 0
    fi
    add_cookies
    ;;
  *)
    echo "Invalid command: $1"
    echo "Use '--help' to see available commands."
    exit 1
    ;;
esac
