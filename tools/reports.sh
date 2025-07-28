#!/usr/bin/env bash

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;32m"
BLUE="${e}[0;34m"
MAGENTA="${e}[0;35m"

exists() {
  command -v "$1" >/dev/null 2>&1
}

cyan() {
  echo -e "${CYAN}${*}${RESET}"
}

red() {
  echo -e "${RED}${*}${RESET}"
}

yellow() {
  echo -e "${YELLOW}${*}${RESET}"
}

green() {
  echo -e "${GREEN}${*}${RESET}"
}

blue() {
  echo -e "${BLUE}${*}${RESET}"
}

magenta() {
  echo -e "${MAGENTA}${*}${RESET}"
}

info() {
  echo -e "${CYAN}${*}${RESET}"
}

usage() {
  local input="$*"
  local before_colon="${input%%:*}"
  local after_colon="${input#*:}"
  echo -e "${GREEN}${before_colon}:${RESET}${after_colon}"
}

commands() {
  local input="$*"
  local before_dash="${input%%--*}"
  local after_dash="${input#*--}"

  echo -e "${BLUE}${before_dash}${RESET}${after_dash}"
}

error() {
  echo -e "${RED}Error: ${*}${RESET}" >&2
  # exit 1
}

success() {
  echo -e "${GREEN}${*}${RESET}"
}

finish() {
  success "Done!"
  echo
  sleep 1
}

on_start() {
  info "                                               "
  info "           __        __   ____ _  __           "
  info "      ____/ /____   / /_ / __/(_)/ /___   _____"
  info "     / __  // __ \ / __// /_ / // // _ \ / ___/"
  info "  _ / /_/ // /_/ // /_ / __// // //  __/(__  ) "
  info " (_)\__,_/ \____/ \__//_/  /_//_/ \___//____/  "
  info "                                               "
  info "                                               "
  read -rp "Do you want to proceed with installation? [y/N] " -n 1 answer
  echo
  if [ "${answer}" != "y" ]; then
    exit
  fi
}

on_finish() {
  success "Everything was successfully done!"
  success "Happy Coding!"
  echo
  echo -ne "$RED"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e "$RESET""$BOLD"',------,'"$RESET"
  echo -ne "$YELLOW"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e "$RESET""$BOLD"'|   /\_/'\'"$RESET"
  echo -ne "$GREEN"'-_-_-_-_-_-_-_-_-_-_-_-_-_-'
  echo -e "$RESET""$BOLD"'~|__( ^ .^)'"$RESET"
  echo -ne "$CYAN"'-_-_-_-_-_-_-_-_-_-_-_-_-_-_'
  echo -e "$RESET""$BOLD"'""  ""'"$RESET"
  echo
  info "P.S: Don't forget to restart a terminal :)"
  echo
}

on_error() {
  echo
  error "Wow... Something serious happened!"
  error "Though, I don't know what really happened :("
  echo
  exit 1
}
