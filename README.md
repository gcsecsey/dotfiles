# dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/) for easy setup across macOS and Windows machines.

Feel free to fork or grab anything useful, but these are tailored to my workflow.

## Setup

### macOS

```bash
brew install chezmoi
chezmoi init https://github.com/gcsecsey/dotfiles
chezmoi apply
```

### Windows (Git Bash / PowerShell)

```powershell
winget install twpayne.chezmoi
chezmoi init https://github.com/gcsecsey/dotfiles
chezmoi apply
```

### WSL (Windows Subsystem for Linux)

After running `chezmoi apply`, manually copy the WSL config (requires sudo):

```bash
sudo cp wsl/wsl.conf /etc/wsl.conf
```

Then restart WSL from PowerShell:
```powershell
wsl --shutdown
```

### Linux

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init https://github.com/gcsecsey/dotfiles
chezmoi apply
```

## After Setup

### Secrets

Create `~/.secrets` for API keys and other sensitive stuff (not tracked):

```bash
# ~/.secrets
export MY_API_KEY='your-key-here'
```

### Claude Code Plugins

After chezmoi apply, run the plugin installer to set up Claude Code plugins:

```bash
./install-claude-plugins.sh
```

This installs:
- `claude-code-meta` — plugin management utilities
- `code-simplifier` — code simplification tools
- `context-a8c` — Automattic internal tools (requires a8c access)

## What's Synced

**Shell:** `.zshrc`, `.zshenv`, `.zprofile`, `.p10k.zsh`

**Terminal:** `.tmux.conf`, `.wezterm.lua`

**Claude Code:**
- `~/.claude/CLAUDE.md` — global instructions
- `~/.claude/settings.json` — permissions, preferences
- `~/.claude/agents/` — custom subagents
- `~/.claude/commands/` — custom slash commands

## Useful Commands

```bash
chezmoi add ~/.config/foo    # Add a new file
chezmoi edit ~/.zshrc        # Edit a managed file
chezmoi diff                 # See pending changes
chezmoi apply                # Apply changes
chezmoi update               # Pull latest and apply
```
