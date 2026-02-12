#!/bin/bash
# Install Claude Code plugins and MCP servers after initial setup
# Run this after `chezmoi apply` on a new machine

echo "Installing Claude Code plugins..."

# Public plugins from claude-plugins-official
echo "Installing public plugins..."
claude /install-plugin code-simplifier@claude-plugins-official
claude /install-plugin superpowers@claude-plugins-official
claude /install-plugin frontend-design@claude-plugins-official
claude /install-plugin playwright@claude-plugins-official

# Automattic internal plugins (requires access to github.a8c.com)
if ssh -T git@github.a8c.com 2>&1 | grep -q "successfully authenticated"; then
    echo "Installing Automattic internal plugins..."
    claude /install-plugin context-a8c@automattic-claude-code-plugins

    echo "Adding context-a8c MCP server..."
    claude mcp add context-a8c \
        --env HTTP_PROXY=http://127.0.0.1:8118 \
        --env HTTPS_PROXY=http://127.0.0.1:8118 \
        -- npx -y @automattic/mcp-context-a8c
else
    echo "Skipping Automattic plugins (no access to github.a8c.com)"
fi

echo "Done! Restart Claude Code to activate plugins."
