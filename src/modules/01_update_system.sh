#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/00_common.sh"
ensure_root

log "Systemupdate"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y

# unattended-upgrades + apt-listchanges
apt_install unattended-upgrades apt-listchanges

# dpkg-reconfigure ist in debconf, wird in harden.sh schon sichergestellt,
# aber hier nochmals robust:
ensure_cmd_or_pkg dpkg-reconfigure debconf

# unattended-upgrades aktivieren (nicht interaktiv)
dpkg-reconfigure -f noninteractive unattended-upgrades || true

ok "Systemupdate abgeschlossen"