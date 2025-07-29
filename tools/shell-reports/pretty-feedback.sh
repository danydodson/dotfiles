#!/usr/bin/env bash

# Feedback functions used in bash scripts

e='\033'
RESET="${e}[0m"
BOLD="${e}[1m"
CYAN="${e}[0;96m"
RED="${e}[0;91m"
YELLOW="${e}[0;93m"
GREEN="${e}[0;32m"
BLUE="${e}[0;34m"
MAGENTA="${e}[0;35m"

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
