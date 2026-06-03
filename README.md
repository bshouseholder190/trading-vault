# 📊 Trading Vault

An interactive Obsidian vault for tracking stocks, options, and crypto trades — with Dataview dashboards, journal templates, price alert tracking, and research notes.

---

## Features

- **Trade Journal** — structured templates for stock, options, and crypto trades with entry/exit tracking and post-trade review
- **Dataview Dashboards** — live-queried tables for open positions, P&L summaries, watchlists, and recent activity
- **Price Alert Tracking** — centralized alert log with active/triggered/expired status
- **Research Notes** — deep-dive templates for fundamental and technical analysis with linked price levels
- **Watchlists** — master watchlist with conviction ratings and sector rotation tracker

---

## Required Plugins

Install these from Obsidian → Settings → Community Plugins:

| Plugin | Purpose |
|--------|---------|
| [Dataview](https://github.com/blacksmithgu/obsidian-dataview) | Powers all dashboard queries |
| [Templater](https://github.com/SilentVoid13/Templater) | Auto-fills date and metadata in new notes |
| [Obsidian Charts](https://github.com/phibr0/obsidian-charts) | Renders price charts inside notes |
| [Tasks](https://github.com/obsidian-tasks-group/obsidian-tasks) | Trade management checklists |
| [Calendar](https://github.com/liamcain/obsidian-calendar-plugin) | Visual trade calendar |

---

## Folder Structure

```
Trading Vault/
├── Dashboard/          # Dataview-powered overview pages
│   ├── Home.md         # Main hub — start here
│   ├── Open Positions.md
│   └── P&L Summary.md
├── Templates/          # Note templates (use with Templater)
│   ├── Trade Journal Entry.md
│   ├── Options Trade.md
│   ├── Stock Research.md
│   └── Crypto Research.md
├── Trades/             # One note per trade
├── Research/
│   ├── Stocks/         # Fundamental + technical research
│   ├── Options/        # Strategy-specific research
│   └── Crypto/         # Token research
├── Alerts/             # Price alert tracking
│   └── Price Alerts.md
└── Watchlists/
    ├── Master Watchlist.md
    └── Sector Map.md
```

---

## Workflow

### New Trade
1. Create note in `Trades/` using the **Trade Journal Entry** or **Options Trade** template
2. Fill in ticker, direction, entry, stop, target in frontmatter
3. Set `status: open`
4. Link to your research note
5. When closed, update `status: closed`, add `exit` and `pnl` fields

### New Research Note
1. Create note in `Research/Stocks/` or `Research/Crypto/` using the appropriate template
2. Fill in fundamentals, bull/bear case, and price levels
3. Add price alerts to `Alerts/Price Alerts.md`
4. Add to `Watchlists/Master Watchlist.md` with conviction rating

### Price Alert
1. Open `Alerts/Price Alerts.md`
2. Add a row to the manual table with ticker, type, price, and status `active`
3. When triggered, update status to `triggered` and log the date

---

## Frontmatter Fields Reference

### Trade
```yaml
date, ticker, type (stock|options|crypto), direction (long|short),
status (open|closed), entry, exit, size, stop-loss, target, pnl, pnl-pct
```

### Options Trade (additional)
```yaml
strategy, expiry, strikes, contracts, debit-credit, max-profit, max-loss,
breakeven, delta, theta, vega, iv-rank
```

### Stock Research
```yaml
company, sector, industry, market-cap, rating, price-target
```

### Crypto Research
```yaml
name, category, chain, market-cap-rank, rating, price-target
```

---

## Chart Embeds

To embed a TradingView chart, use the Obsidian Charts plugin or paste a screenshot:

```
![[chart-NVDA-2026-06-03.png]]
```

For live charts, you can use an iframe (requires the HTML support plugin):

```html
<iframe src="https://www.tradingview.com/widgetembed/?symbol=NVDA&interval=D" width="100%" height="400"></iframe>
```

---

## License

MIT — free to use, fork, and customize.
