#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "Bitte als root ausführen (sudo)"
  exit 1
fi

echo "[+] Starte Raspberry Pi OS Hardening..."

for script in modules/*.sh; do
  echo "[+] Führe $script aus"
  bash "$script"
done

echo "[✓] Hardening abgeschlossen. Reboot empfohlen."

echo "Möchten Sie jetzt neu starten? (j/n)"
read -r answer
if [[ "$answer" =~ ^[Jj]$ ]]; then
  echo "[+] Starte neu..."
  reboot
else
  echo "[+] Neustart übersprungen. Bitte starten Sie das System später neu."
fi