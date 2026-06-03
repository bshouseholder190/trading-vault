---
cssclass: dashboard
---

# 📊 Trading Vault — Home

> Last updated: `=dateformat(date(today), "MMMM d, yyyy")`

---

## 🔗 Quick Links

| Section | Link |
|---|---|
| Open Positions | [[Dashboard/Open Positions]] |
| Watchlist | [[Watchlists/Master Watchlist]] |
| Price Alerts | [[Alerts/Price Alerts]] |
| Today's Journal | [[Trades/]] |

---

## 📈 Recent Trades

```dataview
TABLE ticker, type, direction, entry, exit, pnl, status
FROM "Trades"
SORT date DESC
LIMIT 10
```

---

## 🚨 Active Price Alerts

```dataview
TABLE ticker, alert-type, target-price, current-note, status
FROM "Alerts"
WHERE status = "active"
SORT ticker ASC
```

---

## 📂 Research Notes (Recent)

```dataview
TABLE ticker, sector, rating
FROM "Research"
SORT file.mtime DESC
LIMIT 8
```

---

## 📅 This Week's Activity

```dataview
CALENDAR date
FROM "Trades"
WHERE date >= date(today) - dur(7 days)
```
