---
cssclass: dashboard
---

# 🚨 Price Alerts

> Manage your price alerts here. Update `status` to `triggered` or `expired` when done.
> Use the Dataview tables below to track all active alerts at a glance.

---

## How to Add an Alert

Create a new note in this folder using the format below, or just add rows directly to the table at the bottom of this note.

---

## Active Alerts

```dataview
TABLE
  ticker,
  alert-type AS "Type",
  target-price AS "Target $",
  current-note AS "Note",
  research-link AS "Research",
  date-set AS "Set On"
FROM "Alerts"
WHERE status = "active"
SORT ticker ASC
```

---

## Triggered Alerts

```dataview
TABLE
  ticker,
  alert-type AS "Type",
  target-price AS "Target $",
  date-set AS "Set",
  date-triggered AS "Triggered"
FROM "Alerts"
WHERE status = "triggered"
SORT date-triggered DESC
LIMIT 20
```

---

## Alert Log (All)

| Ticker | Type | Target $ | Note | Status | Set | Triggered |
|--------|------|----------|------|--------|-----|-----------|
| | | | | active | | |

---

## Alert Types Reference

| Type | Meaning |
|---|---|
| `buy-zone` | Price enters your accumulation range |
| `breakout` | Price clears key resistance |
| `breakdown` | Price loses key support |
| `stop-loss` | Exit alert for risk management |
| `target-1` | First profit-taking level |
| `target-2` | Full exit / extended target |
| `earnings` | Earnings date reminder |
| `catalyst` | Event-based alert |
