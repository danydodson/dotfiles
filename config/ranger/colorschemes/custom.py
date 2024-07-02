from ranger.gui.colorscheme import ColorScheme  # type: ignore
from ranger.gui.color import black, white, green, red, blue, magenta, yellow, cyan, bold, underline, dim, reverse, normal, default, BRIGHT  # type: ignore


class ColorStack:
    """
    Simple builder for colors and attributes, as declarative prototype.
    Allows some kind of inheritance by overriding values that are not explicitly set.

    Note that the original scheme sets bold together with bright for best compatibility.
    Also adds bright only, underline, and dim as first class options for supporting terminal emulators.
    The reverse and dim attributes should be used sparingly, as inversions do not add up properly.
    """

    def __init__(self, fg=None, bg=None, is_bright=None, is_bold=None, is_underline=None, is_dim=None, is_reverse=None) -> None:
        self._fg = fg
        self._bg = bg
        self._bright = is_bright
        self._bold = is_bold
        self._underline = is_underline
        self._dim = is_dim
        self._reverse = is_reverse

    def copy(self, other):
        """Create from prototype, assigning could mutate the config classvars."""
        self._set(fg=other._fg, bg=other._bg, bright=other._bright, bold=other._bold,
                  underline=other._underline, dim=other._dim, reverse=other._reverse)
        return self

    def add(self, other):
        """Override explicitly set attributes, which is the current 'inheritance' approach."""
        self._add(fg=other._fg, bg=other._bg, bright=other._bright, bold=other._bold,
                  underline=other._underline, dim=other._dim, reverse=other._reverse)
        return self

    def _add(self, **kwargs):
        self._set(**{k: v for k, v in kwargs.items() if v is not None})

    def _set(self, **kwargs):
        for k, v in kwargs.items():
            setattr(self, '_' + k, v)

    def get(self):
        """Build overall result as the expected tuple. No special logic on senseful combinations atm."""
        fg = self._fg if self._fg is not None else default
        bg = self._bg if self._bg is not None else default
        attr = normal
        if self._bright is True:
            fg += BRIGHT
        if self._bold is True:
            attr |= bold
        if self._underline is True:
            attr |= underline
        if self._dim is True:
            attr |= dim
        if self._reverse is True:
            attr |= reverse
        return fg, bg, attr


class Custom(ColorScheme):
    """
    Customizable color scheme on the basis of context attributes.
    The defaults are intended to replicate the appearance and logic of the default scheme.

    Copy to: dist-packages/ranger/colorschemes/custom.py or confdir/colorschemes/custom.py
    Configure with: set colorscheme custom
    """

    LS_COLORS = {
        'directory': ColorStack(fg=blue, is_bright=True, is_bold=True),
        'link': ColorStack(fg=cyan, is_bright=True, is_bold=True),
        'link_bad': ColorStack(fg=red, is_bright=True, is_bold=True),
        'socket': ColorStack(fg=magenta, is_bright=True, is_bold=True),
        'fifo': ColorStack(fg=magenta, is_bright=True, is_bold=True),
        'device': ColorStack(fg=magenta, is_bright=True, is_bold=True),
        'file': ColorStack(),  # default for the ones below
        'executable': ColorStack(fg=green, is_bright=True, is_bold=True),
        'container': ColorStack(fg=red),
        'document': ColorStack(),
        'video': ColorStack(fg=magenta),
        'audio': ColorStack(fg=cyan),
        'image': ColorStack(fg=yellow),
        'media': ColorStack(fg=magenta),
    }

    BROWSER_COLORS = {
        # reverse, fixed colors, underline, etc
        'selected': ColorStack(is_bright=True, is_bold=True, is_dim=False, is_reverse=True),
        'error': ColorStack(fg=red, is_bright=True, is_bold=True),
        'marked': ColorStack(fg=yellow, bg=default, is_bright=True, is_bold=True, is_underline=False),
        'copied': ColorStack(fg=black, bg=default, is_bright=True, is_bold=True, is_underline=False),
        # asterisk
        'tag_marker': ColorStack(fg=red, is_bright=True, is_bold=True),
        'tagged': ColorStack(),
        'infostring': ColorStack(),  # size
        # multi-pane multi-tab
        'inactive_pane': ColorStack(fg=cyan, bg=normal),
    }

    VCS_COLORS = {
        # default
        'status': ColorStack(is_bright=False, is_bold=False, is_underline=False),
        'ignored': ColorStack(fg=default),
        'untracked': ColorStack(fg=cyan),
        'unknown': ColorStack(fg=red),
        'conflict': ColorStack(fg=magenta),
        'changed': ColorStack(fg=red),
        'staged': ColorStack(fg=green),
        'sync': ColorStack(fg=green),
        'none': ColorStack(fg=green),
        'behind': ColorStack(fg=red),
        'ahead': ColorStack(fg=blue),
        'diverged': ColorStack(fg=magenta),
    }

    TITLE_COLORS = {
        'in_titlebar': ColorStack(is_bright=True, is_bold=True),  # default
        'hostname': ColorStack(fg=green),
        'hostname_bad': ColorStack(fg=red),  # when root
        'directory': ColorStack(fg=blue),
        'link': ColorStack(fg=cyan),
        'file': ColorStack(),  # current selection
        'keybuffer': ColorStack(),
        'tab': ColorStack(),
        'tab_good': ColorStack(bg=green),  # current tab
    }

    STATUS_COLORS = {
        'in_statusbar': ColorStack(),  # default
        'text': ColorStack(is_reverse=False),
        'text_highlight': ColorStack(is_reverse=True),
        'permissions': ColorStack(fg=cyan),
        'permissions_bad': ColorStack(fg=magenta),
        'nlink': ColorStack(),
        'owner': ColorStack(),
        'group': ColorStack(),
        'mtime': ColorStack(),
        'percentage': ColorStack(),  # top, btm, all, percentage
        # Mrk
        'marked': ColorStack(fg=yellow, is_bright=True, is_bold=True, is_reverse=True),
        'frozen': ColorStack(fg=cyan, is_bright=True, is_bold=True, is_reverse=True),
        'message': ColorStack(),
        'message_bad': ColorStack(fg=red, is_bright=True, is_bold=True),
        'vcsinfo': ColorStack(fg=blue),
        'vcscommit': ColorStack(fg=yellow),
        'vcsdate': ColorStack(fg=cyan),
        'progress_bar': ColorStack(fg=white, bg=blue, is_bright=False, is_dim=False, is_reverse=False),
    }

    TASK_COLORS = {
        'title': ColorStack(fg=blue),
        'error': ColorStack(fg=red),
        'selected': ColorStack(is_reverse=True),
        'progress_bar': ColorStack(fg=white, bg=blue, is_bright=False, is_dim=False, is_reverse=False),
    }

    def use(self, context):
        colors = ColorStack()

        if context.reset:
            return colors.get()

        if context.in_browser:
            if context.empty or context.error or context.badinfo:
                colors.copy(self.BROWSER_COLORS['error'])
            elif context.link:
                colors.copy(
                    self.LS_COLORS['link'] if context.good else self.LS_COLORS['link_bad'])
            elif context.fifo:
                colors.copy(self.LS_COLORS['fifo'])
            elif context.device:
                colors.copy(self.LS_COLORS['device'])
            elif context.socket:
                colors.copy(self.LS_COLORS['socket'])
            elif context.directory:
                colors.copy(self.LS_COLORS['directory'])
            elif context.executable:
                colors.copy(self.LS_COLORS['file']).add(
                    self.LS_COLORS['executable'])
            elif context.container:
                colors.copy(self.LS_COLORS['file']).add(
                    self.LS_COLORS['container'])
            elif context.document:
                colors.copy(self.LS_COLORS['file']).add(
                    self.LS_COLORS['document'])
            elif context.video:
                colors.copy(self.LS_COLORS['file']).add(
                    self.LS_COLORS['video'])
            elif context.audio:
                colors.copy(self.LS_COLORS['file']).add(
                    self.LS_COLORS['audio'])
            elif context.image:
                colors.copy(self.LS_COLORS['file']).add(
                    self.LS_COLORS['image'])
            elif context.media:
                colors.copy(self.LS_COLORS['file']).add(
                    self.LS_COLORS['media'])
            elif context.file:
                colors.copy(self.LS_COLORS['file'])

            if context.selected:
                colors.add(self.BROWSER_COLORS['selected'])
            elif context.tag_marker:
                colors.copy(self.BROWSER_COLORS['tag_marker'])
            elif context.marked:
                colors.add(self.BROWSER_COLORS['marked'])
            elif context.cut or context.copied:
                colors.add(self.BROWSER_COLORS['copied'])
            elif context.tagged:
                colors.add(self.BROWSER_COLORS['tagged'])
            elif context.infostring:
                colors.add(self.BROWSER_COLORS['infostring'])

            if context.inactive_pane:
                colors.add(self.BROWSER_COLORS['inactive_pane'])

        elif context.in_titlebar:
            colors.copy(self.TITLE_COLORS['in_titlebar'])

            if context.hostname:
                colors.add(
                    self.TITLE_COLORS['hostname_bad'] if context.bad else self.TITLE_COLORS['hostname'])
            elif context.directory:
                colors.add(self.TITLE_COLORS['directory'])
            elif context.link:
                colors.add(self.TITLE_COLORS['link'])
            elif context.file:
                colors.add(self.TITLE_COLORS['file'])
            elif context.keybuffer:
                colors.add(self.TITLE_COLORS['keybuffer'])
            elif context.tab:
                colors.add(
                    self.TITLE_COLORS['tab_good'] if context.good else self.TITLE_COLORS['tab'])

        elif context.in_statusbar:
            colors.copy(self.STATUS_COLORS['in_statusbar'])

            if context.permissions:
                colors.add(
                    self.STATUS_COLORS['permissions'] if context.good else self.STATUS_COLORS['permissions_bad'])
            elif context.nlink:
                colors.add(self.STATUS_COLORS['nlink'])
            elif context.owner:
                colors.add(self.STATUS_COLORS['owner'])
            elif context.group:
                colors.add(self.STATUS_COLORS['group'])
            elif context.mtime:
                colors.add(self.STATUS_COLORS['mtime'])
            elif context.marked:
                colors.add(self.STATUS_COLORS['marked'])
            elif context.all or context.bot or context.top or context.percentage:
                colors.add(self.STATUS_COLORS['percentage'])
            elif context.frozen:
                colors.add(self.STATUS_COLORS['frozen'])
            elif context.message:
                colors.add(
                    self.STATUS_COLORS['message_bad'] if context.bad else self.STATUS_COLORS['message'])
            elif context.vcsinfo:
                colors.add(self.STATUS_COLORS['vcsinfo'])
            elif context.vcscommit:
                colors.add(self.STATUS_COLORS['vcscommit'])
            elif context.vcsdate:
                colors.add(self.STATUS_COLORS['vcsdate'])

            if context.text:
                colors.add(self.STATUS_COLORS['text_highlight']
                           if context.highlight else self.STATUS_COLORS['text'])

            if context.loaded:
                colors.add(self.STATUS_COLORS['progress_bar'])

        elif context.in_taskview:
            if context.error:
                colors.copy(self.TASK_COLORS['error'])
            elif context.title:
                colors.copy(self.TASK_COLORS['title'])
            if context.selected:
                colors.add(self.TASK_COLORS['selected'])
            if context.loaded:
                colors.add(self.TASK_COLORS['progress_bar'])

        if context.vcsfile and not context.selected:
            if context.vcsconflict:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['conflict'])
            elif context.vcsuntracked:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['untracked'])
            elif context.vcschanged:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['changed'])
            elif context.vcsunknown:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['unknown'])
            elif context.vcsstaged:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['staged'])
            elif context.vcssync:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['sync'])
            elif context.vcsignored:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['ignored'])
        elif context.vcsremote and not context.selected:
            if context.vcssync or context.vcsnone:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['sync'])
            if context.vcsnone:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['none'])
            elif context.vcsbehind:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['behind'])
            elif context.vcsahead:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['ahead'])
            elif context.vcsdiverged:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['diverged'])
            elif context.vcsunknown:
                colors.add(self.VCS_COLORS['status']).add(
                    self.VCS_COLORS['unknown'])

        return colors.get()
