# Copilot Instructions for AI Agents

Welcome to the `dotfiles` repo! This project manages a highly modular, idempotent dotfiles setup for macOS, using [Dotbot](https://github.com/anishathalye/dotbot) as the core orchestrator. Follow these guidelines to be productive as an AI coding agent in this codebase:

## Architecture & Structure
- **Dotbot-based:** All setup is orchestrated via Dotbot, configured in `install.yaml`. Dotbot is vendored in `plugins/dotbot/`.
- **Config-centric:** All user and app configs live under `config/`, organized by app (e.g., `config/zsh/`, `config/nvim/`, `config/ssh/`).
- **Scripts:** Custom shell utilities and setup scripts are in `bin/` and `setup/`.
- **Platform:** macOS is the primary target. Some paths and scripts are macOS-specific (e.g., LaunchAgents, `/Applications/`, `~/Library/`).

## Key Workflows
- **Install/Update:**
  - Run `./install` from the repo root to (re)link dotfiles and run setup steps. This uses `install.yaml` as the main config.
  - To preview changes, use `./install --dry-run`.
  - To update submodules: `git submodule update --init --recursive` (also run by Dotbot shell step).
- **Adding new configs:**
  - Place new config files in the appropriate `config/` subfolder.
  - Add link rules to `install.yaml` to symlink them into place.
- **Custom scripts:**
  - Place user scripts in `bin/` (for CLI tools) or `setup/` (for setup routines).
  - Reference these scripts in `install.yaml` shell steps if they should run during setup.

## Project Conventions
- **Idempotency:** All install steps must be safe to run multiple times.
- **Symlinks:** Use symlinks for all config files, not copies. Use Dotbot's `link` directive.
- **Globs:** Use Dotbot's `glob` and `exclude` for batch linking directories (see `install.yaml`).
- **macOS-specific:** Some config paths (e.g., `~/Library/`, `/Applications/`) are hardcoded for macOS.
- **Submodules:** Plugins and external tools are managed as git submodules in `plugins/`.
- **Sensitive data:** Secrets (e.g., SSH, GPG) are stored in `config/ssh/`, `config/gnupg/`, etc. Do not hardcode secrets.

## Integration Points
- **Dotbot plugins:** Custom Dotbot plugins can be added to `plugins/` and referenced in `install.yaml`.
- **External tools:** Homebrew, Python, and other tools may be referenced in `setup/` scripts or Dotbot shell steps.
- **Editor configs:** VS Code, Neovim, and other editor configs are in `config/` and linked to their expected locations.

## Examples
- To add a new Neovim config: place files in `config/nvim/`, then add a `link` entry in `install.yaml` to `~/.config/nvim`.
- To add a new CLI tool: place the script in `bin/`, make it executable, and optionally add a link in `install.yaml`.

## References
- Main entrypoint: `install.yaml`
- Dotbot docs: `plugins/dotbot/README.md`
- Project overview: `readme.md`
- Custom scripts: `bin/`, `setup/`
- App configs: `config/`

---

**When in doubt, follow the structure and patterns in `install.yaml` and `config/`.**
