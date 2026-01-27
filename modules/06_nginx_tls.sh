#!/bin/bash

echo "[*] Nginx + TLS vorbereiten"

apt install -y nginx

cat <<EOF > /etc/nginx/snippets/security.conf
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
add_header Referrer-Policy strict-origin;
add_header Content-Security-Policy "default-src https: data: 'unsafe-inline'";
EOF

cat <<EOF > /etc/nginx/snippets/ssl.conf
ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers on;
EOF

echo "[✓] Nginx + TLS Vorbereitung abgeschlossen"