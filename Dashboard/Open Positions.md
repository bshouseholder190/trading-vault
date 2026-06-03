---
cssclass: dashboard
---

# 📂 Open Positions

```dataview
TABLE
  ticker,
  type AS "Type",
  direction AS "Long/Short",
  entry AS "Entry $",
  size AS "Size",
  stop-loss AS "Stop",
  target AS "Target",
  date AS "Opened",
  notes
FROM "Trades"
WHERE status = "open"
SORT date DESC
```

---

## Options Positions

```dataview
TABLE
  ticker,
  strategy AS "Strategy",
  expiry AS "Expiry",
  strikes AS "Strikes",
  debit-credit AS "Debit/Credit",
  delta AS "Delta",
  theta AS "Theta",
  status
FROM "Trades"
WHERE type = "options" AND status = "open"
SORT expiry ASC
```

---

## Crypto Positions

```dataview
TABLE
  ticker,
  entry AS "Entry $",
  size,
  stop-loss AS "Stop",
  target AS "Target",
  date AS "Opened"
FROM "Trades"
WHERE type = "crypto" AND status = "open"
SORT date DESC
```
