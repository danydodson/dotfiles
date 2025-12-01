# AGENTS.md — Dotfiles Repo Guidelines
Scope: Root-level; applies to entire repository.
Build: No global build; optional plugin: `make -C plugins/zsh-suggestions`.
Lint/Format — Lua: `stylua .` (uses `.stylua.toml`; 2 spaces; no require sorting).
Lint/Format — Shell (bash): `shellcheck **/*.sh bin/*`; fix SC* warnings.
Lint/Format — Zsh: `zsh -n <file>` for syntax; avoid shellcheck-only zsh code.
Lint/Format — Shell format: `shfmt -w -i 2 -ci **/*.sh`.
Lint/Format — YAML/JSON/MD: `yamllint .`; `jq . file > tmp && mv`; `markdownlint .`.
Tests: No repo-wide tests; vendored plugin tests are available.
Tests — all: `make -C plugins/zsh-suggestions test` (bundler may be required).
Tests — single: `make -C plugins/zsh-suggestions test TESTS=spec/async_spec.rb`.
Code Style — Lua: target Lua 5.4; heed `.luarc.json` diagnostics; prefer `pcall`/`assert` around I/O.
Code Style — Imports: group built-ins → external → local; do not auto-sort `require`.
Code Style — Naming: `bin/` scripts kebab-case; Lua functions/locals snake_case; constants UPPER_SNAKE_CASE.
Code Style — Errors: Bash `set -Eeuo pipefail` + `trap`; Zsh `set -e` and `set -o pipefail` where supported.
Code Style — Formatting: keep lines concise; avoid trailing whitespace; UTF-8; Unix line endings.
Commit Hygiene: keep diffs minimal; avoid touching vendored `plugins/*` unless you’re fixing that code.
Tooling: install `stylua`, `shellcheck`, `shfmt`, `yamllint`, `markdownlint-cli`, `jq` as needed.
Editors: follow project configs; e.g., `.stylua.toml` and `.luarc.json`.
Cursor/Copilot: none found (`.cursor/`, `.cursorrules`, `.github/copilot-instructions.md` absent).