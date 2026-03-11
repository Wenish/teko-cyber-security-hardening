#!/usr/bin/env bash
set -euo pipefail

# Sauberer PATH (wichtig fuer sshd/ufw/sysctl/nginx)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

log()  { echo -e "[*] $*"; }
ok()   { echo -e "[+] $*"; }
warn() { echo -e "[!] $*"; }
err()  { echo -e "[-] $*" >&2; }

is_root() { [[ "${EUID:-$(id -u)}" -eq 0 ]]; }

ensure_root() {
  if ! is_root; then
    err "Bitte als root ausfuehren (sudo)."
    exit 1
  fi
}

apt_install() {
  # Usage: apt_install pkg1 pkg2 ...
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y >/dev/null
  apt-get install -y --no-install-recommends "$@"
}

have_cmd() { command -v "$1" >/dev/null 2>&1; }

ensure_cmd_or_pkg() {
  # Usage: ensure_cmd_or_pkg <cmd> <pkg>
  local cmd="$1" pkg="$2"
  if ! have_cmd "$cmd"; then
    warn "Command '$cmd' fehlt -> installiere Paket '$pkg'"
    apt_install "$pkg"
  fi
}

ensure_service_exists() {
  # Usage: ensure_service_exists ssh.service
  local svc="$1"
  systemctl list-unit-files | awk '{print $1}' | grep -qx "$svc"
}

safe_restart() {
  local svc="$1"
  if command -v systemctl >/dev/null 2>&1; then
    systemctl restart "$svc" || true
  else
    service "$svc" restart || true
  fi
}