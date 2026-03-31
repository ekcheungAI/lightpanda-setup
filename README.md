# lightpanda-setup

Hermes Agent skill for installing and configuring [LightPanda](https://github.com/lightpanda-io/browser) — the headless browser built for AI agents.

## What this covers

- Binary installation (Linux x86_64)
- CDP server setup (Playwright/Puppeteer compatible)
- Systemd service for auto-start on boot
- MCP integration with Claude Code
- Puppeteer test verification

## Performance

- **16x less memory** than Chrome headless
- **9x faster** execution
- ~892KB idle memory
- Instant startup

## Usage

See `SKILL.md` for full step-by-step instructions.

## Compatibility

- Tested on Ubuntu 22.04/24.04 x86_64
- CDP compatible: Playwright, Puppeteer, chromedp
- MCP compatible: Claude Code
