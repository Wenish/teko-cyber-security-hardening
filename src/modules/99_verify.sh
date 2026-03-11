#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/00_common.sh"
ensure_root

log "Verifikation"

echo "--- SSH ---"
if have_cmd sshd; then
  sshd -T | egrep "passwordauthentication|permitrootlogin" || true
else
  warn "sshd nicht im PATH / nicht installiert"
fi

echo "--- Firewall ---"
if have_cmd ufw; then
  ufw status verbose || true
else
  warn "ufw nicht im PATH / nicht installiert"
fi

echo "--- Fail2Ban ---"
if have_cmd fail2ban-client; then
  fail2ban-client status sshd || true
else
  warn "fail2ban-client nicht gefunden"
fi

ok "Verifikation abgeschlossen"