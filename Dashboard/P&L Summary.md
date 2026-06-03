---
cssclass: dashboard
---

# 💰 P&L Summary

## All Closed Trades

```dataview
TABLE
  ticker,
  type,
  direction,
  entry,
  exit,
  pnl AS "P&L ($)",
  pnl-pct AS "P&L (%)",
  date AS "Close Date"
FROM "Trades"
WHERE status = "closed"
SORT date DESC
```

---

## Win Rate by Asset Type

```dataview
TABLE
  rows.file.name AS "Trades",
  length(filter(rows, (r) => r.pnl > 0)) AS "Wins",
  length(filter(rows, (r) => r.pnl <= 0)) AS "Losses"
FROM "Trades"
WHERE status = "closed"
GROUP BY type
```

---

## Monthly Performance

```dataview
TABLE
  rows.file.name AS "Trades",
  sum(rows.pnl) AS "Total P&L"
FROM "Trades"
WHERE status = "closed"
GROUP BY dateformat(date, "yyyy-MM")
SORT key DESC
```
