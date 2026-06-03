# ============================================================
# update-vault-data.ps1
# Run this from the Trading Vault folder whenever you add or
# update Research notes in Obsidian. It regenerates
# docs/vault-data.json, which the live dashboard reads.
#
# Usage:
#   cd "C:\Users\bshou\OneDrive\Documents\Claude\Projects\Trading Vault"
#   .\update-vault-data.ps1
# ============================================================

$VaultRoot  = $PSScriptRoot
$OutFile    = Join-Path $VaultRoot "docs\vault-data.json"
$StocksDir  = Join-Path $VaultRoot "Research\Stocks"
$CryptoDir  = Join-Path $VaultRoot "Research\Crypto"
$TradesDir  = Join-Path $VaultRoot "Trades"
$AlertsFile = Join-Path $VaultRoot "Alerts\Price Alerts.md"

# ── Helper: parse YAML frontmatter from a .md file ──────────────────────────
function Get-Frontmatter($path) {
    $lines = Get-Content $path -Encoding UTF8
    $inFm  = $false
    $fm    = @{}
    foreach ($line in $lines) {
        if ($line -eq '---') {
            if (-not $inFm) { $inFm = $true; continue }
            else             { break }
        }
        if ($inFm -and $line -match '^(\w[\w\-]*):\s*(.*)$') {
            $key = $Matches[1].Trim()
            $val = $Matches[2].Trim().Trim('"').Trim("'")
            $fm[$key] = $val
        }
    }
    return $fm
}

# ── Helper: extract a markdown section by heading ────────────────────────────
function Get-Section($path, $heading) {
    $lines   = Get-Content $path -Encoding UTF8
    $capture = $false
    $items   = @()
    foreach ($line in $lines) {
        if ($line -match "^##\s+$heading") { $capture = $true; continue }
        if ($capture -and $line -match '^##\s') { break }
        if ($capture -and $line -match '^\d+\.\s+(.+)$') { $items += $Matches[1].Trim() }
        if ($capture -and $line -match '^-\s+(.+)$')     { $items += $Matches[1].Trim() }
    }
    return $items
}

# ── Parse Research/Stocks ────────────────────────────────────────────────────
$stocks = @()
if (Test-Path $StocksDir) {
    Get-ChildItem $StocksDir -Filter "*.md" | ForEach-Object {
        $fm       = Get-Frontmatter $_.FullName
        $bullCase = Get-Section $_.FullName "Bull Case"
        $bearCase = Get-Section $_.FullName "Bear Case"
        if ($fm['ticker']) {
            $stocks += [ordered]@{
                ticker      = $fm['ticker'].ToUpper()
                company     = $fm['company']    -as [string]
                sector      = $fm['sector']     -as [string]
                industry    = $fm['industry']   -as [string]
                rating      = $fm['rating']     -as [string]   # bullish | bearish | neutral | watchlist
                priceTarget = if ($fm['price-target']) { [double]$fm['price-target'] } else { $null }
                marketCap   = $fm['market-cap'] -as [string]
                tags        = if ($fm['tags']) { $fm['tags'] -replace '[\[\]]','' -split ',' | ForEach-Object { $_.Trim() } } else { @() }
                bullCase    = $bullCase
                bearCase    = $bearCase
                sourceFile  = $_.Name
                lastUpdated = $fm['date'] -as [string]
            }
        }
    }
}

# ── Parse Research/Crypto ────────────────────────────────────────────────────
$crypto = @()
if (Test-Path $CryptoDir) {
    Get-ChildItem $CryptoDir -Filter "*.md" | ForEach-Object {
        $fm       = Get-Frontmatter $_.FullName
        $bullCase = Get-Section $_.FullName "Bull Case"
        $bearCase = Get-Section $_.FullName "Bear Case"
        if ($fm['ticker']) {
            $crypto += [ordered]@{
                ticker      = $fm['ticker'].ToUpper()
                name        = $fm['name']       -as [string]
                category    = $fm['category']   -as [string]
                chain       = $fm['chain']      -as [string]
                cgId        = $fm['ticker'].ToLower()   # CoinGecko ID fallback
                rating      = $fm['rating']     -as [string]
                priceTarget = if ($fm['price-target']) { [double]$fm['price-target'] } else { $null }
                bullCase    = $bullCase
                bearCase    = $bearCase
                sourceFile  = $_.Name
                lastUpdated = $fm['date'] -as [string]
            }
        }
    }
}

# ── Parse active trades ───────────────────────────────────────────────────────
$openTrades = @()
if (Test-Path $TradesDir) {
    Get-ChildItem $TradesDir -Filter "*.md" | ForEach-Object {
        $fm = Get-Frontmatter $_.FullName
        if ($fm['ticker'] -and $fm['status'] -eq 'open') {
            $openTrades += [ordered]@{
                ticker    = $fm['ticker'].ToUpper()
                type      = $fm['type']      -as [string]
                direction = $fm['direction'] -as [string]
                entry     = if ($fm['entry'])     { [double]$fm['entry'] }     else { $null }
                stopLoss  = if ($fm['stop-loss']) { [double]$fm['stop-loss'] } else { $null }
                target    = if ($fm['target'])    { [double]$fm['target'] }    else { $null }
                date      = $fm['date'] -as [string]
            }
        }
    }
}

# ── Strategy criteria from investing.md ──────────────────────────────────────
# These come from the TOS trading strategy note
$strategy = [ordered]@{
    rsiMin             = 50       # RSI(14) minimum — avoid buying weak momentum
    rsiMax             = 70       # RSI(14) maximum — avoid chasing overbought
    ivrMaxDirectional  = 30       # IVR max for debit/directional trades
    ivrMinNeutral      = 50       # IVR min for credit/neutral trades
    volumeMultiplier   = 1.2      # Entry volume must be 1.2x 20-day average
    maxRiskPct         = 1        # Max risk per trade as % of account
    maxConcurrent      = 5        # Max open positions at once
    stopLossPct        = 8        # Default stop at 8% below entry
    profitTargetPct    = 50       # Close credit spreads at 50% of max gain
    preferredTimeRange = "9:45-11:30 or 14:00-15:30 ET"
    indicators         = @("21 EMA", "50 SMA", "200 SMA", "RSI(14)", "ATR(14)", "Volume MA(20)", "VWAP")
}

# ── Assemble and write JSON ───────────────────────────────────────────────────
$output = [ordered]@{
    generatedAt       = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
    stockCount        = $stocks.Count
    cryptoCount       = $crypto.Count
    openTradeCount    = $openTrades.Count
    stocks            = $stocks
    crypto            = $crypto
    openTrades        = $openTrades
    strategy          = $strategy
}

$json = $output | ConvertTo-Json -Depth 10
$json | Out-File -FilePath $OutFile -Encoding utf8 -Force

Write-Host ""
Write-Host "✅ vault-data.json generated successfully" -ForegroundColor Green
Write-Host "   Stocks:      $($stocks.Count)" -ForegroundColor Cyan
Write-Host "   Crypto:      $($crypto.Count)" -ForegroundColor Cyan
Write-Host "   Open trades: $($openTrades.Count)" -ForegroundColor Cyan
Write-Host "   Output:      $OutFile" -ForegroundColor Cyan
Write-Host ""
Write-Host "Run 'git add docs/vault-data.json && git commit -m ""update vault data"" && git push' to publish." -ForegroundColor Yellow
