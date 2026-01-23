#!/bin/bash
# Install Claude Code plugins after initial setup
# Run this after `chezmoi apply` on a new machine

echo "Installing Claude Code plugins..."

# Public plugins
echo "Installing public plugins..."
claude /install-plugin code-simplifier@claude-plugins-official

# Automattic internal plugins (requires access to github.a8c.com)
if ssh -T git@github.a8c.com 2>&1 | grep -q "successfully authenticated"; then
    echo "Installing Automattic internal plugins..."
    claude /install-plugin context-a8c@automattic-claude-code-plugins
else
    echo "Skipping Automattic plugins (no access to github.a8c.com)"
fi

echo "Done! Restart Claude Code to activate plugins."
