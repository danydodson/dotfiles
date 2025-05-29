#!/usr/bin/env bash

# Installs go packages

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

function install_go_packages() {
    if exists go; then
        info "Installing go packages..."
        go install golang.org/dl/gotip@latest
        go install golang.org/x/tools/cmd/godoc@latest
        go install github.com/lotusirous/gostdsym/stdsym@latest
        go install github.com/go-delve/delve/cmd/dlv@latest
        go install golang.org/x/tools/gopls@latest
        go install mvdan.cc/gofumpt@latest
        go install golang.org/x/tools/cmd/deadcode@latest
        go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
        go install github.com/segmentio/golines@latest
        go install gotest.tools/gotestsum@latest
        echo
    else
        error "Error: go is not available"
    fi
    finish
}

main() {
    install_go_packages "$*"
    on_finish "$*"
}

main "$*"
