# # Get Bundle ID of macOS app
# # Example: bundleid terminal

# bundleid() {
#   local ID=$( osascript -e 'id of app "'"$1"'"' )
#   if [ ! -z $ID ]; then
#     echo $ID | tr -d '[:space:]' | pbcopy
#     echo "$ID (copied to clipboard)"
#   fi
# }
