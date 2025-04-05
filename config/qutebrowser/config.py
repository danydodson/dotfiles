config.load_autoconfig()

config.source('qutebrowser-themes/onedark.py')

# c.colors.webpage.bg = ''
# c.colors.webpage.darkmode.enabled = True
# c.colors.webpage.preferred_color_scheme = 'auto'

c.window.hide_decoration = True

c.statusbar.show = 'in-mode'
c.statusbar.widgets = ['keypress', 'search_match', 'url', 'progress']
c.statusbar.padding = {'top': 1, 'bottom': 1, 'left': 4, 'right': 4}

c.auto_save.session = True

c.completion.height = "20%"

c.scrolling.smooth = True
c.scrolling.bar = 'overlay'

c.downloads.location.prompt = True

c.editor.command = ['codium', '-n', '{file}', '-w']

c.fileselect.folder.command = ['ghostty', '-e', 'yazi', '--choosedir={}']

c.url.start_pages = "about:blank"  # "https://ape3000.com/"
c.url.default_page = "about:blank"  # "https://roadmap.sh/"

c.url.searchengines = {
    "DEFAULT": "https://www.google.fi/search?q={}",
    'ddg': 'https://duckduckgo.com/?q={}'
}

c.hints.border = '1px solid #c7a51e'

c.content.autoplay = False
c.content.pdfjs = True
c.content.user_stylesheets = ["user.css"]
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'

config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://secure.fanboy.co.nz/fanboy-mobile-notifications.txt',
    'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt',
]

c.content.blocking.whitelist = [
    # 'https://danydodson.dev'
    # 'https://tinder.com'
    # 'https://bumble.com'
    # 'https://idmsa.apple.com',
    # 'https://policies.google.com',
]

config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')

c.qt.highdpi = True

c.tabs.show = "multiple"
c.tabs.last_close = 'blank'
c.tabs.indicator.width = 0
c.tabs.background = True
c.tabs.title.format = "{audio} {current_title}"
c.tabs.title.format_pinned = ''
c.tabs.pinned.frozen = False
c.tabs.favicons.show = "always"
c.tabs.favicons.scale = 1.0
c.tabs.width = 200
c.tabs.max_width = 200
c.tabs.wrap = False

c.colors.tabs.selected.even.bg = "#202429"
c.colors.tabs.selected.odd.bg = c.colors.tabs.selected.even.bg
c.colors.tabs.selected.even.fg = "#b7c8ed"
c.colors.tabs.selected.odd.fg = c.colors.tabs.selected.even.fg

c.colors.tabs.even.bg = "#202429"
c.colors.tabs.odd.bg = c.colors.tabs.even.bg
c.colors.tabs.even.fg = "#464c5a"
c.colors.tabs.odd.fg = c.colors.tabs.even.fg

c.colors.tabs.pinned.even.bg = '#202429'
c.colors.tabs.pinned.odd.bg = c.colors.tabs.pinned.even.bg
c.colors.tabs.pinned.even.fg = '#464c5a'
c.colors.tabs.pinned.odd.fg = c.colors.tabs.pinned.even.fg

c.colors.tabs.pinned.selected.even.bg = '#202429'
c.colors.tabs.pinned.selected.odd.bg = c.colors.tabs.pinned.selected.even.bg
c.colors.tabs.pinned.selected.even.fg = '#b7c8ed'
c.colors.tabs.pinned.selected.odd.fg = c.colors.tabs.pinned.selected.even.fg

c.tabs.padding = {"left": 5, "right": 5, "top": 0, "bottom": 2}

config.bind(',mpv', 'spawn --detach mpv {url}')

config.bind("<Shift+Cmd+,>", "config-source")

config.bind('h', 'scroll left')
config.bind('j', 'scroll down')
config.bind('k', 'scroll up')
config.bind('l', 'scroll right')

config.bind("<ctrl+k>", "tab-next")
config.bind("<ctrl+j>", "tab-prev")

config.unbind("<ctrl+q>")
config.bind("<ctrl+q>", "wq")

config.bind('1p', 'spawn --userscript 1password')

config.bind('xs', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')

config.bind(
    ',ap', 'config-cycle content.user_stylesheets ~/.qutebrowser/user.css ""')
