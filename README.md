# LightPanda Setup Skill

A complete installation and configuration guide for [LightPanda](https://github.com/lightpanda-io/browser) — the headless browser built for AI agents and automation.

## What This Covers

- Binary installation (single curl)
- Verify + fetch test
- CDP server (Playwright/Puppeteer compatible)
- Systemd service for auto-start on boot
- MCP integration with Claude Code

## Performance (vs Chrome, 933 real pages, AWS EC2 m5.large)

| Metric | LightPanda | Chrome |
|---|---|---|
| Memory at idle | ~892KB | ~150MB+ |
| Execution speed | 9x faster | baseline |
| Memory usage | 16x less | baseline |
| Startup | Instant | Slow |

## Quick Install (Linux x86_64)

```bash
curl -L -o /usr/local/bin/lightpanda https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux
chmod a+x /usr/local/bin/lightpanda
```

## Test Fetch

```bash
LIGHTPANDA_DISABLE_TELEMETRY=true lightpanda fetch --dump markdown --strip-mode full https://example.com
```

## Start CDP Server

```bash
LIGHTPANDA_DISABLE_TELEMETRY=true lightpanda serve --host 127.0.0.1 --port 9222 --log-level warn &
curl -s http://127.0.0.1:9222/json/version
```

## Puppeteer Test

```js
import puppeteer from 'puppeteer-core';
const browser = await puppeteer.connect({ browserWSEndpoint: 'ws://127.0.0.1:9222/' });
const page = await (await browser.createBrowserContext()).newPage();
await page.goto('https://example.com');
console.log(await page.title());
await browser.disconnect();
```

## Systemd Service

See [lightpanda.service](lightpanda.service) — copy to `/etc/systemd/system/` and:

```bash
sudo systemctl daemon-reload
sudo systemctl enable lightpanda
sudo systemctl start lightpanda
```

## MCP Integration (Claude Code)

Add to `~/.claude/mcp.json`:

```json
{
  "mcpServers": {
    "lightpanda": {
      "type": "stdio",
      "command": "/usr/local/bin/lightpanda",
      "args": ["mcp"],
      "env": {
        "LIGHTPANDA_DISABLE_TELEMETRY": "true"
      }
    }
  }
}
```

## Commands

| Command | Description |
|---|---|
| `lightpanda fetch --dump markdown URL` | Fetch URL as markdown |
| `lightpanda fetch --dump html URL` | Fetch URL as HTML |
| `lightpanda serve --port 9222` | Start CDP server |
| `lightpanda mcp` | Start MCP server |
| `lightpanda version` | Show version |

## Notes

- CORS is still pending (WIP) — SPAs relying on CORS may break
- Pin Playwright versions — new Web API additions can shift code paths
- AGPL-3.0 license
- 26k+ GitHub stars as of March 2026
