#!/bin/bash

# Installs go packages

. "$HOME/.dotfiles/bin/reports"

set -e
trap on_error SIGTERM

function install_go_packages() {
  if exists go; then
    info "Installing go packages..."

    if ! which gotip >/dev/null 2>&1; then
      go install golang.org/dl/gotip@latest
    fi
    if ! which godoc >/dev/null 2>&1; then
      go install golang.org/x/tools/cmd/godoc@latest
    fi
    if ! which stdsym >/dev/null 2>&1; then
      go install github.com/lotusirous/gostdsym/stdsym@latest
    fi
    if ! which dlv >/dev/null 2>&1; then
      go install github.com/go-delve/delve/cmd/dlv@latest
    fi
    if ! which gopls >/dev/null 2>&1; then
      go install golang.org/x/tools/gopls@latest
    fi
    if ! which gofumpt >/dev/null 2>&1; then
      go install mvdan.cc/gofumpt@latest
    fi
    if ! which deadcode >/dev/null 2>&1; then
      go install golang.org/x/tools/cmd/deadcode@latest
    fi
    if ! which golangci-lint >/dev/null 2>&1; then
      go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    fi
    if ! which golines >/dev/null 2>&1; then
      go install github.com/segmentio/golines@latest
    fi
    if ! which gotestsum >/dev/null 2>&1; then
      go install gotest.tools/gotestsum@latest
    fi
  else
    error "Error: go is not available"
  fi
}

main() {
  install_go_packages "$*"
}

main "$*"
