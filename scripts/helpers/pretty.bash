#!/usr/bin/env bash

#######################################################################
# std logging                                                         #
# Based on http://serverwizard.heroku.com/script/rvm+git              #
# added error output to stderr                                        #
#######################################################################

_echo() {
	printf ' %s\033[0;m\n' "$1"
}

info() {
	printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"
}
info_() {
	printf '\033[0;34m %s\033[0;m\n' "$1"
}

user() {
	printf '\033[0;35m[USER] \033[0;35m%s\033[0;m\n' "$1"
}
user_() {
	printf '\033[0;35m %s\033[0;m\n' "$1"
}

ok() {
	printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"
}
ok_() {
	printf '\033[0;36m %s\033[0;m\n' "$1"
}

warn() {
	printf '\033[0;32m[WARN] \033[0;32m%s\033[0;m\n' "$1"
}
warn_() {
	printf '\033[0;32m %s\033[0;m\n' "$1"
}

err() {
	printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"
}
err_() {
	printf '\033[0;31m %s\033[0;m\n' "$1"
}

warning() {
	printf '\033[0;32m[WARNING] %s\033[0;m\n' "$1" >&2
}
warning_() {
	printf '\033[0;32m %s\033[0;m\n' "$1" >&2
}

error() {
	printf '\033[31m[ERROR]\033[0m %s\n' "$1" >&2
}
error_() {
	printf '\033[0;31m %s\033[0;m\n' "$1" >&2
}
