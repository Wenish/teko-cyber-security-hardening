#!/bin/bash

SSH_CONFIG="/etc/ssh/sshd_config"

echo "[*] SSH Hardening"

sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' $SSH_CONFIG
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' $SSH_CONFIG
sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' $SSH_CONFIG
sed -i 's/^#\?MaxAuthTries.*/MaxAuthTries 3/' $SSH_CONFIG
sed -i 's/^#\?X11Forwarding.*/X11Forwarding no/' $SSH_CONFIG

systemctl restart ssh

echo "[✓] SSH Hardening abgeschlossen"