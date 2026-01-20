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

### Linux

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init https://github.com/gcsecsey/dotfiles
chezmoi apply
```

## After Setup

Create `~/.secrets` for API keys and other sensitive stuff (not tracked):

```bash
# ~/.secrets
export MY_API_KEY='your-key-here'
```

## Useful Commands

```bash
chezmoi add ~/.config/foo    # Add a new file
chezmoi edit ~/.zshrc        # Edit a managed file
chezmoi diff                 # See pending changes
chezmoi apply                # Apply changes
chezmoi update               # Pull latest and apply
```
