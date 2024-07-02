#!/usr/bin/env bash

# Kitty Console command

# Ideal requirements:
# - If kitty is running:
#   - If there is no console window
#     - Create the console window, bring it to focus
#   - If there is a console window
#     - If it is not in focus or hidden, bring it to focus
#     - If it is in focus, hide the console window
# Bonus:
# - If kitty is not running:
#   - Launch kitty, create the console window, bring it to focus

# If a logfile is specified, it will write information there
logfile="${HOME}/.config/skhd/kitty_console.log"

function kclog {
  [[ -n "${logfile}" ]] && printf -- "$*\n" &>>"${logfile}"
}

kclog 'Launching Kitty Console Script.'
kclog "Which kitty = $(which kitty)"

function minimal_prototype {
  SOCKET='unix:/tmp/kitty-gui'
  kitty_cmd="kitty @ --to ${SOCKET}"

  # Save the below, this works well
  # 1) If kitty is not running, reports in log
  # 2) If kitty running and no Console window exists, creates one
  # 3) If kitty running and Console window exists, bring it to focus
  # Note that this requires the following in
  # ~/.config/kitty/macos-launch-services-cmd-line:
  # --override allow_remote_control=yes
  # --listen-on unix:/tmp/kitty-gui

  ${kitty_cmd} focus-window --match title:Console ||
    ${kitty_cmd} new-window --window-type os --title Console ||
    {
      printf 'Kitty likely not running, launching \n' >"${logfile}"
      kitty --single-instance --directory "${HOME}" --override allow_remote_control=yes --listen-on "${SOCKET}" --title Console
    }
}

function minimal_prototype_2 {
  SOCKET='unix:/tmp/kitty-gui'
  kitty_cmd="kitty @ --to ${SOCKET}"

  # Save the below, this works well
  # 1) If kitty is not running, reports in log and launches kitty normally,
  #    then launches console window
  # 2) If kitty running and no Console window exists, creates one
  # 3) If kitty running and Console window exists, bring it to focus
  # Note that this requires the following in
  # ~/.config/kitty/macos-launch-services-cmd-line:
  # --override allow_remote_control=yes
  # --listen-on unix:/tmp/kitty-gui

  ${kitty_cmd} focus-window --match title:Console ||
    ${kitty_cmd} new-window --window-type os --title Console ||
    {
      printf 'Kitty likely not running, launching \n' >"${logfile}"
      /Applications/kitty.app/Contents/MacOS/kitty --single-instance --directory "${HOME}" --override allow_remote_control=yes --listen-on "${SOCKET}" &
      sleep 1
      ${kitty_cmd} new-window --window-type os --title Console
    }
}

function minimal_prototype_3 {
  SOCKET='unix:/tmp/kitty-console'
  kitty_cmd="kitty @ --to ${SOCKET}"
  # This version launches a separate kitty instance for console

  # Save the below, this works well
  # 1) If kitty is not running, reports in log and launches kitty normally,
  #    then launches console window
  # 2) If kitty running and no Console window exists, creates one
  # 3) If kitty running and Console window exists, bring it to focus
  # Note that this requires the following in
  # ~/.config/kitty/macos-launch-services-cmd-line:
  # --override allow_remote_control=yes
  # --listen-on unix:/tmp/kitty-gui

  ${kitty_cmd} focus-window --match title:Console ||
    ${kitty_cmd} new-window --window-type os --title Console ||
    {
      printf 'Kitty likely not running, launching \n' >"${logfile}"
      kitty --directory "${HOME}" --override macos_hide_from_tasks=yes --override allow_remote_control=yes --listen-on "${SOCKET}" &
      sleep 1
      ${kitty_cmd} new-window --window-type os --title Console
    }
  yabai -m rule --add app=kitty title=Console sticky=on
}

function simple_kitty_console {
  # This function implements a simple console window.
  SOCKET='unix:/tmp/kitty-gui'
  kitty_cmd="kitty @ --to ${SOCKET}"
  if ${kitty_cmd} focus-window --match title:Console; then
    kclog 'Focusing Console window'
  else
    kclog 'No Console window, create.'
    ${kitty_cmd} new-window --window-type os --title Console &&
      yabai -m rule --add \
        label=kitty-console \
        app=kitty \
        title=Console \
        sticky=on \
        grid=1:2:2:1:1:1 \
        manage=on
  fi
}

function hide_process {
  osascript -e "
        tell application \"System Events\"
            set visible of the first process whose unix id is ${1} to false
        end tell
    "
}

function show_process {
  osascript -e "
        tell application \"System Events\"
            set visible of the first process whose unix id is ${1} to true
        end tell
    "

}

function activate_process {
  # Assumes that variable `myProcessId` contains the PID of interest.
  osascript -e "
        tell application \"System Events\"
            set frontmost of the first process whose unix id is ${1} to true
        end tell
        "
}

function independent_kitty_console {
  # This function launches an independent kitty instance
  # This function implements a simple console window.
  SOCKET='unix:/tmp/kitty-console'
  kitty_cmd="kitty @ --to ${SOCKET}"
  # if ${kitty_cmd} focus-window --match title:Console; then
  if ${kitty_cmd} focus-window; then
    kclog 'Focusing Console window'
  else
    kclog 'No Console window, create.'
    launch_new_hidden_kitty
    # ${kitty_cmd} new-window --window-type os --title Console \
    #     && yabai -m rule --add \
    #         label=kitty-console \
    #         app=kitty \
    #         title=Console \
    #         sticky=on \
    #         grid=1:2:2:1:1:1 \
    #         manage=on
  fi
  :
}

function launch_new_kitty {
  SOCKET='unix:/tmp/kitty-console'
  { kitty --title Console --directory '/' --listen-on "${SOCKET}" & } 2>/dev/null
  kitty_pid=$!
  disown -r "${kitty_pid}"
  printf "${kitty_pid}\n"
}

function launch_new_hidden_kitty {
  # This works well to launch a hidden instance of Kitty and get the PID, but
  # it seems that kitty windows launched in this way do not respond the same
  # way to the Apple events the way 'non-hidden' Kitty windows do.
  SOCKET='unix:/tmp/kitty-console'
  { kitty --title Console --override macos_hide_from_tasks=yes --directory '/' --listen-on "${SOCKET}" & } 2>/dev/null
  kitty_pid=$!
  disown -r "${kitty_pid}"

  kclog "${kitty_pid}"
  # Attempt to rename the window on launch
  kitty @ --to "${SOCKET}" set-window-title -m recent:0 Console
}

function learnings {
  # Get the process ID of the bash instance inside kitty window
  kitty @ --to unix:/tmp/kitty-console ls | jq '.[].tabs[].windows[].pid'

  # From this, one can use
  ps -f $KITTY_BASH_PID

  # To get the main kitty PID
}

function kitty_console_post_fix {
  # This is work performed after I saw the following fix:
  # https://github.com/kovidgoyal/kitty/issues/5210
  # This function implements a simple console window.
  # This uses the "launch" command
  SOCKET='unix:/tmp/kitty-gui'
  kitty_cmd="kitty @ --to ${SOCKET}"
  if ${kitty_cmd} focus-window --match title:Console; then
    kclog 'Focusing Console window'
  else
    kclog 'No Console window, create.'
    ${kitty_cmd} launch --type=os-window --title=Console &&
      yabai -m rule --add \
        label=kitty-console \
        app=kitty \
        title=Console \
        sticky=on \
        grid=1:2:2:1:1:1 \
        manage=on
  fi

}

function independent_kitty_console_post_fix {
  kclog '\nRunning independent_kitty_console_post_fix'
  # This function launches an independent kitty instance
  # This function implements a simple console window.
  SOCKET='unix:/tmp/kitty-console'
  kitty_cmd="kitty @ --to ${SOCKET}"
  if ${kitty_cmd} focus-window --match title:Console; then
    kclog 'Focusing Console window'
  else
    launch_new_hidden_kitty
    # if ${kitty_cmd} launch --type=os-window --title=Console \
    #     --override macos_hide_from_tasks=yes; then
    #     kclog 'No Console window, create.'
    #     yabai -m rule --add \
    #         label=kitty-console \
    #         app=kitty \
    #         title=Console \
    #         sticky=on \
    #         grid=1:2:2:1:1:1 \
    #         manage=on
    # else
    #     kclog 'No Kitty instance, launching'
    #     { kitty --override macos_hide_from_tasks=yes --directory '/' --listen-on "${SOCKET}" & } 2>/dev/null
    #     kitty_pid=$!
    #     disown -r "${kitty_pid}"
    #     kclog "${kitty_pid}\n"
    # ${kitty_cmd} launch --type=os-window --title=Console \
    #     && yabai -m rule --add \
    #         label=kitty-console \
    #         app=kitty \
    #         title=Console \
    #         sticky=on \
    #         manage=on
    #         # grid=1:2:2:1:1:1 \
    # fi
  fi
}

# simple_kitty_console
# independent_kitty_console
# kitty_console_post_fix
# independent_kitty_console_post_fix

################################################################################
# Another try - 2022-09-12
################################################################################
# This tries to achieve my goal using a separate instance of kitty for the
# Console window. Codename: ibk (itty bitty kitty)

IBK_SOCKET='unix:/tmp/kitty-console'

function ibk_launch {
  # Launch a Console instance of Kitty
  # Note: I launch it using the root directory as an extra way of identifying
  # which instance is the Console instance.
  kitty \
    --title Console \
    --directory "${HOME}" \
    --override allow_remote_control=yes \
    --listen-on "${IBK_SOCKET}"
}

function ibk_launch_background {
  # Launch a Console instance of Kitty
  # Note: I launch it using the root directory as an extra way of identifying
  # which instance is the Console instance.
  {
    kitty \
      --title Console \
      --directory "${HOME}" \
      --override allow_remote_control=yes \
      --listen-on "${IBK_SOCKET}" &
  } &>/dev/null
  kitty_pid=$!
  disown -r "${kitty_pid}"
  # yabai -m rule --add \
  #     label=kitty-console \
  #     app=kitty \
  #     title=Console \
  #     sticky=on
  # echo -n "${kitty_pid}"
}

function ibk_get_pid {
  # Get the pid of the kitty process in order to hide it
  # local ppids
  # ppids=$(
  # Note: if kitty ls returns '[]', no windows exist
  _ppids="$(
    kitty @ --to "${IBK_SOCKET}" ls |
      jq '.[].tabs[].windows[].pid' |
      xargs -I {} ps -o ppid= {} |
      sort |
      uniq
  )"
  num_ppids=$(echo "$_ppids" | wc -l)
  if [[ "${num_ppids// /}" == '1' && -n "${_ppids}" ]]; then
    echo -n "${_ppids}"
  else
    return 1
  fi
}

function ibk_hide {
  hide_process "$(ibk_get_pid)"
}

function ibk_show {
  show_process "$(ibk_get_pid)"
}

function ibk_focus {
  activate_process "$(ibk_get_pid)"
}

function ibk_is_hidden {
  # I'm not sure how to do this yet, but I'll need to check whether or not
  # the instance of kitty is hidden.
  :
}

function ibk_toggle {
  osascript -e "
        tell application \"System Events\"
            if frontmost of the first process whose unix id is ${1} then
                set visible of the first process whose unix id is ${1} to false
            else
                set frontmost of the first process whose unix id is ${1} to true
            end if
        end tell
        "
}

function ibk_kitty_console {
  # Todo: Add ability to hide if currently in focus with same function
  if ibk_pid=$(ibk_get_pid) &>/dev/null; then
    ibk_toggle "${ibk_pid}"
    # ibk_focus "${ibk_pid}"
  else
    # Either not running, or has no windows open
    if [[ '[]' == "$(kitty @ --to "${IBK_SOCKET}" ls)" ]]; then
      # Running, but has no windows open, create one
      kitty @ --to "${IBK_SOCKET}" launch --type=os-window
    else
      # Not running, launch
      ibk_launch_background
    fi
  fi
  ibk_ensure_yabai_managed
}

function ibk_ensure_yabai_managed {
  yabai -m rule --list | grep -q '"label":"kitty-console"' ||
    yabai -m rule --add \
      label=kitty-console \
      app=kitty \
      title=Console \
      sticky=on
}

ibk_kitty_console
