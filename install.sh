#!/bin/bash
set -e

echo "Installing LightPanda..."
curl -L -o /usr/local/bin/lightpanda https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux
chmod a+x /usr/local/bin/lightpanda
echo "Binary installed at /usr/local/bin/lightpanda"

echo "Testing fetch..."
LIGHTPANDA_DISABLE_TELEMETRY=true lightpanda fetch --dump markdown --strip-mode full https://example.com

echo "Installing systemd service..."
cp lightpanda.service /etc/systemd/system/lightpanda.service
systemctl daemon-reload
systemctl enable lightpanda
systemctl start lightpanda
systemctl status lightpanda --no-pager

echo "Done! CDP server running at ws://127.0.0.1:9222"
echo "Add mcp-snippet.json contents to ~/.claude/mcp.json for Claude Code integration."
