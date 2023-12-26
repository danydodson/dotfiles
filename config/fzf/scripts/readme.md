# fzf-scripts
This is a collection of scripts I have created that make use of fzf. Majority are written using python :( I am trying to learn more bash scripting.

## fzf-bookman
fzf-bookman will let you select a url from history in qutebrowser.

**TODO**: Select bookmarks and select history from other browsers

## fzf-confedit
In config variables defined the `conf` variable, you can select one and open it in your favorite editor.
## fzf-hub
fzf-hub will try to launch scripts in the fzf-scripts folder. Not perfect at doing it however...

## fzf-librex
This script makes a lot of use of librex and it's API. You can search the web, search videos mostly on YouTube, search images, search and download torrents from a variety of torrent sites all in fzf! Librex's API changes a lot and can be janky at times so please report if something is not working. I will try my best to fix it.

## fzf-reddit
For a variety of subreddits in the `subs` variable. You can select one of them, see the most recent posts, then select a post and see the content.

**TODO**: Somehow view comments...

## fzf-search
fzf-search allows you to search a lot of platforms for a search term. Then it opens the browser with search results. 

## fzf-twitch
In fzf-twitch's variables you can type in what streamers you want to see. After doing this fzf will check each one if any of them is live, if not it will check if there is a stream schedule for when is the streamer's next scheduled stream. You can select in the fzf prompt streamers that are live and play them with the player variable. I recommend using streamlink so that way you can skip advertisements. The issue with that is streamlink leaves a terminal window open where it prints out stuff that doesn't really matter. Inside streamlink you can configure it to use mpv. If this is too complicated you can just use mpv directly.

## fzf-wezchanger
This script is for the cross platform terminal: wezterm. Wezterm in the config file supports many themes. fzf-wezchanger will allow you to select from wezterm's supported themes and change the theme on the fly. This might not work for all configuration files users have created for wezterm. For mine it works. 

**TODO**: Maybe one day this will support alacritty but, alacritty is very minimal and requires separate YAML files for themes which the config file then needs to load. If there is some work around or Git repo with a bunch of alacritty themes please tell me. 
## config.py
This is where basic variables like player, image viewer are stored so they are the same for fzf-scripts. If you want to use one script alone without all the other scripts just copy variables from config.py and you should be ok... Or find which variables are being used from config.py in that specific script.

## fzf-hn **WIP**
Should be able to select recent hacker news posts. Right now trying to be able to make it view comments.

# Ideas 
- https://codeberg.org/zortazert/Python-Projects/src/branch/main/api/fakeyou.py make this fzf
- Rom recents opener

# Similar projects
Basically any fuzzy finder script using dmenu, rofi, fzf, jgmenu, etc somewhere on the internet. I use only fzf because it works cross platform on Windows. These scripts should be able to work with any other fuzzy finder theoretically.
- [Distrotube's dmscripts](https://gitlab.com/dwt1/dmscripts)
- [Luke Smith's dmenu scripts](https://github.com/LukeSmithxyz/voidrice/tree/master/.local/bin) `dmenuhandler`, `dmenumount`, `dmenumountcifs`, `dmenupass`, `dmenurecord`, `dmenuumount`, `dmenuunicode`
