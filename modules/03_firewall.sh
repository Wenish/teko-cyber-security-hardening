#!/bin/bash

echo "[*] Firewall (UFW) konfigurieren"

apt install -y ufw

ufw --force reset
ufw default deny incoming
ufw default allow outgoing

ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

ufw --force enable

echo "[✓] Firewall Konfiguration abgeschlossen"