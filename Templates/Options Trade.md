---
date: <% tp.date.now("YYYY-MM-DD") %>
ticker: 
type: options
strategy:   # long-call | long-put | covered-call | cash-secured-put | vertical | iron-condor | straddle | strangle | calendar | diagonal
direction: long  # long | short (net premium)
status: open  # open | closed | expired
expiry: 
strikes: 
contracts: 
debit-credit:   # positive = debit paid, negative = credit received
max-profit: 
max-loss: 
breakeven: 
delta: 
theta: 
vega: 
iv-rank:   # IV rank at entry (0-100)
pnl: 
pnl-pct: 
tags: [trade, options]
---

# Options Trade: {{ticker}} {{strategy}} — <% tp.date.now("YYYY-MM-DD") %>

## Strategy Overview

**Strategy:** `{{strategy}}`

**Outlook:** Bullish / Bearish / Neutral / Volatility Play

**Thesis:**
> Why this trade? What are you expressing?

---

## Position Details

| Field | Value |
|---|---|
| Ticker | |
| Strategy | |
| Expiry | |
| Strike(s) | |
| Contracts | |
| Debit / Credit | |
| Max Profit | |
| Max Loss | |
| Breakeven | |

---

## Greeks at Entry

| Greek | Value |
|---|---|
| Delta | |
| Gamma | |
| Theta | |
| Vega | |
| IV Rank | |
| IV Percentile | |

---

## Trade Management Rules

- **Take profit at:** % of max profit
- **Stop loss at:** % of max loss
- **Roll if:** 
- **Close before expiry:** days out

---

## Chart & Setup

![[chart-screenshot.png]]

**Key levels:**
- Support:
- Resistance:
- Expected move (1 SD):

---

## Adjustments

| Date | Action | Details | New Greeks |
|---|---|---|---|
| | | | |

---

## Close

**Close date:**
**Close price / credit:**
**P&L:** `$` (`%`)
**Reason for close:**

---

## Post-Trade Review

**What went right?**

**What went wrong?**

**IV crush / expansion impact:**

**Grade:** A / B / C / D

---

## Links

- Underlying research: [[Research/Stocks/]]
