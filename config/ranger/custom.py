import subprocess

from ranger.api.commands import Command  # type: ignore
from ranger.container.fsobject import FileSystemObject  # type: ignore
from ranger.core.filter_stack import stack_filter, BaseFilter, AndFilter, NotFilter, NameFilter  # type: ignore
from ranger.core.fm import FM  # type: ignore


@stack_filter("vcsstatus")
class VcsStatusFilter(BaseFilter):
    """
    Filter by comma-separated or present vcsstatus state:
    conflict, untracked, deleted, changed, staged, ignored, sync, none, unknown
    """

    def __init__(self, status='') -> None:
        self._status = status.split(',') if status else []

    def __call__(self, fobj: FileSystemObject):
        if self._status:
            return fobj.vcsstatus in self._status
        else:
            return fobj.vcsstatus is not None

    def __str__(self):
        return "<Filter: vcsstatus in {}>".format(",".join(self._status)) if self._status else "<Filter: vcsstatus>"


class flatten(Command):
    """
    Toggle flat view, which recursively crawls the whole directory.
    Based on: https://github.com/ranger/ranger/wiki/Custom-Commands
    """

    def execute(self):
        flat: int = -1 if self.fm.thisdir.flat != -1 else 0
        self.fm.thisdir.unload()
        self.fm.thisdir.flat = flat
        self.fm.thisdir.load_content()


class rfind(Command):
    """
    Like flatten, but post-filter by optionally given name pattern and vcs ignore.
    """

    def execute(self):
        fm: FM = self.fm
        pat: str = self.rest(1)

        if fm.thisdir.flat != -1:
            fm.thisdir.unload()
            fm.thisdir.flat = -1
            fm.thisdir.filter_stack.clear()
            fm.thisdir.filter_stack.append(
                VcsStatusFilter('ignored,untracked'))
            NotFilter(fm.thisdir.filter_stack)
            if pat:
                fm.thisdir.filter_stack.append(NameFilter(pat))
                AndFilter(fm.thisdir.filter_stack)
            fm.thisdir.load_content()
        else:
            fm.thisdir.filter_stack.clear()
            fm.thisdir.filter_stack.append(
                VcsStatusFilter('ignored,untracked'))
            NotFilter(fm.thisdir.filter_stack)
            if pat:
                fm.thisdir.filter_stack.append(NameFilter(pat))
                AndFilter(fm.thisdir.filter_stack)
            fm.thisdir.refilter()


class rgrep(Command):
    """
    Call grep on the given pattern for all files, mark matches.
    """

    def execute(self):
        fm: FM = self.fm
        fm.mark_files(all=True, val=False, movedown=False)

        if not self.rest(1):
            fm.notify('Syntax: {} <pattern>'.format(
                self.__class__.__name__), bad=True)
            return

        action = ['grep', '--files-with-matches', '--binary-files=without-match', '--no-messages',
                  '-E', '-e', self.rest(1), '--']

        files = [_ for _ in fm.thisdir.files if _.is_file and not _.is_link]
        num_files: int = len(files)
        num_results: int = 0
        status: int = 0

        while len(files):
            # avoid '[Errno 7] Argument list too long' by less than ARG_MAX/PATH_MAX
            chunk, files = {_.path: _ for _ in files[:256]}, files[256:]

            # own Popen, as no suitable mode for stdin only and no toggle_ui in fm.execute_command
            grep = subprocess.Popen(  # close_fds=True, shell=False
                action + list(chunk.keys()), universal_newlines=True,
                stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, stdin=subprocess.DEVNULL,
            )

            for line in grep.stdout:
                result = chunk.get(line.rstrip())
                if result is None:
                    continue

                if num_results == 0:  # go to first result
                    fm.thisdir.move_to_obj(result)
                num_results += 1

                # mark file object instead of path, no need to select
                fm.thisdir.mark_item(result, True)

            grep.wait()
            if grep.returncode > 1:  # no lines were selected
                status |= grep.returncode

        fm.notify('{}: {} result{}, {} file{}, status {}'.format(
            self.__class__.__name__,
            num_results, 's' if num_results != 1 else '',
            num_files, 's' if num_files != 1 else '',
            status,
        ), bad=status != 0)
