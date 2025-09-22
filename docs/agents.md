### Launch Agents ⌨️

#### Script management with launchd in Terminal on Mac

The launchd process is used by macOS to manage daemons and agents, and you can use it to run your shell scripts. You don’t interact with [launchd](manlaunchd) directly; instead you use the [launchctl](x-man-page://launchctl) command to load or unload launchd daemons and agents.

During system startup, launchd is the first process the kernel runs to set up the computer. If you want your shell script to be run as a daemon, it should be started by launchd. Other mechanisms for starting daemons and agents are subject to removal at Apple’s discretion.

You can get an idea of the various daemons and agents managed by launchd by looking at the configuration files in the following folders:

| Folder                        | Usage                                                    |
| ----------------------------- | -------------------------------------------------------- |
| /System/Library/LaunchDaemons | Apple-supplied system daemons                            |
| /System/Library/LaunchAgents  | Apple-supplied agents that apply to all users per-user   |
| /Library/LaunchDaemons        | Third-party system daemons                               |
| /Library/LaunchAgents         | Third-party agents that apply to all users per-user      |
| ~/Library/LaunchAgents        | Third-party agents that apply only to the logged-in user |

Install launch agents:

```bash
cp $HOME/.dotfiles/macos/agents/maxfiles.plist ~/Library/LaunchAgents/dots.maxfiles.plist
launchctl load ~/Library/LaunchAgents/dots.maxfiles.plist

cp $HOME/.dotfiles/macos/agents/maxproc.plist ~/Library/LaunchAgents/dots.maxproc.plist
launchctl load ~/Library/LaunchAgents/dots.maxproc.plist

cp $HOME/.dotfiles/macos/agents/mpv.plist ~/Library/LaunchAgents/dots.mpv.plist
launchctl load ~/Library/LaunchAgents/dots.mpv.plist

cp $HOME/.dotfiles/macos/agents/mozenv.plist ~/Library/LaunchAgents/dots.mozenv.plist
launchctl load ~/Library/LaunchAgents/dots.mozenv.plist
```
