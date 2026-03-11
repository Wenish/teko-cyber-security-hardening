#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/00_common.sh"
ensure_root

log "Kernel & Netzwerk Hardening"

ensure_cmd_or_pkg sysctl procps

SYSCTL_FILE="/etc/sysctl.d/99-hardening.conf"

cat > "$SYSCTL_FILE" <<'EOF'
# IP Spoofing / Routing
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.accept_source_route=0
net.ipv4.conf.default.accept_source_route=0

# ICMP redirects
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.send_redirects=0

# SYN flood basics
net.ipv4.tcp_syncookies=1

# IPv6 (nur wenn du es wirklich nutzt -> sonst aus)
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
EOF

sysctl --system >/dev/null

ok "Kernel & Netzwerk Hardening abgeschlossen"