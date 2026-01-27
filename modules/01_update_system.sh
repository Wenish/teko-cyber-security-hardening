#!/bin/bash

echo "[*] Systemupdate"

apt update
apt full-upgrade -y
apt install -y unattended-upgrades apt-listchanges

dpkg-reconfigure -f noninteractive unattended-upgrades

echo "[✓] Systemupdate abgeschlossen"