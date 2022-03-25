#!/bin/sh

if test ! "$(uname)" = "Darwin"; then
  exit 0
fi

# Install xcode if necesserary
if type xcode-select >&- && xpath=$(xcode-select --print-path) &&
  test -d "${xpath}" && test -x "${xpath}"; then
  echo ""
  echo ">>>>> Skipping Xcode installation"
else
  echo ""
  echo ">>>>> xcode-select --install"
  xcode-select --install
fi

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

echo ""
echo ">>>>> sudo softwareupdate -i -a"
echo ""

if test "$(uname)" = "Darwin"; then
  sudo softwareupdate -ia
fi
