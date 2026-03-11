#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/00_common.sh"
ensure_root

log "Firewall (UFW) konfigurieren"

ensure_cmd_or_pkg ufw ufw

# Defaults
ufw default deny incoming
ufw default allow outgoing

# Allow SSH
ufw allow 22/tcp

# Optional: Web (wenn du nginx spaeter willst)
ufw allow 80/tcp
ufw allow 443/tcp

# Enable
ufw --force enable

ok "Firewall Konfiguration abgeschlossen"