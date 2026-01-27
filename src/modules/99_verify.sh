#!/bin/bash

echo "[*] Verifikation"

echo "--- SSH ---"
sshd -T | grep -E "passwordauthentication|permitrootlogin"

echo "--- Firewall ---"
ufw status verbose

echo "--- Fail2Ban ---"
fail2ban-client status sshd || true

echo "[✓] Verifikation abgeschlossen"