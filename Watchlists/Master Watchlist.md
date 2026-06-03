---
cssclass: dashboard
---

# 👀 Master Watchlist

> Add tickers here with conviction level, setup type, and a link to your research note.
> Green-light = ready to trade. Yellow = still building thesis. Red = avoid for now.

---

## Stocks

```dataview
TABLE
  ticker,
  sector,
  setup AS "Setup",
  conviction AS "Conviction",
  entry-zone AS "Entry Zone",
  catalyst,
  rating
FROM "Research/Stocks"
WHERE rating != "archived"
SORT conviction DESC
```

---

## Options Setups

```dataview
TABLE
  ticker,
  strategy AS "Strategy",
  expiry,
  conviction AS "Conviction",
  iv-rank AS "IV Rank",
  catalyst
FROM "Research/Stocks"
WHERE tags contains "options-setup"
SORT conviction DESC
```

---

## Crypto

```dataview
TABLE
  ticker,
  category,
  conviction AS "Conviction",
  entry-zone AS "Entry Zone",
  market-cap-rank AS "MC Rank",
  rating
FROM "Research/Crypto"
WHERE rating != "archived"
SORT conviction DESC
```

---

## Manual Watchlist

Add tickers here for quick reference before a research note is created:

| Ticker | Type | Why Watching | Setup | Priority |
|--------|------|--------------|-------|----------|
| | stock | | | high |
| | crypto | | | medium |
