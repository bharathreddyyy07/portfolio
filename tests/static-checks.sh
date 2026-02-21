#!/usr/bin/env bash
set -euo pipefail

# Ensure typo is fixed
if rg -n "CVE Dependency issues" index.html >/dev/null; then
  echo "Found old typo in index.html"
  exit 1
fi

# Ensure only one scroll listener for scroll effects is registered directly
scroll_listeners=$(rg -n "window\.addEventListener\('scroll'" script.js | wc -l | tr -d ' ')
if [[ "$scroll_listeners" -ne 2 ]]; then
  echo "Expected exactly 2 scroll listeners (button visibility + consolidated handler), found $scroll_listeners"
  exit 1
fi

# Ensure comment matches behavior
rg -n "PAGE LOAD STATE MANAGEMENT" script.js >/dev/null
rg -n "document\.body\.classList\.add\('loaded'\)" script.js >/dev/null

echo "Static checks passed"
