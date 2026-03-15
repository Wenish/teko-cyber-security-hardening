# Debian Hardening Script

## Beschreibung
Dieses Projekt stellt ein automatisiertes Hardening-Script für Debian zur Verfügung.  
Das Script härtet ein frisch installiertes System, ohne die Funktionalität als Webserver einzuschränken.

Nach der Ausführung sind folgende Funktionen weiterhin möglich:
- SSH-Zugriff ausschliesslich per SSH-Key
- Betrieb als Webserver mit HTTPS
- Sichere WebSocket-Verbindungen (WSS)

Das Hardening erfolgt modular und reproduzierbar.

---

## Ziel
Ziel dieses Projekts ist es, die Angriffsfläche eines Debian-Systems zu reduzieren und gängige Sicherheitsrisiken zu minimieren, ohne produktive Dienste zu blockieren.

---

## Voraussetzungen
- Debian 13.3
- Frische oder sauber vorbereitete Debian-Installation
- Internetverbindung
- Bestehender SSH-Key für den Benutzer
- Root-Rechte (sudo)

**Wichtig:**  
Vor der Ausführung muss sichergestellt sein, dass mindestens ein SSH-Key eingerichtet ist.  
Andernfalls ist nach dem Hardening kein SSH-Zugriff mehr möglich.

---

## Projektstruktur

```text
src/
├── harden.sh
├── check.sh
├── modules/
│   ├── 00_common.sh
│   ├── 01_update_system.sh
│   ├── 02_users_ssh.sh
│   ├── 03_firewall.sh
│   ├── 04_fail2ban.sh
│   ├── 05_sysctl.sh
│   ├── 06_nginx_tls.sh
│   ├── 07_disable_services.sh
│   ├── 09_sudo_hardening.sh
│   ├── 11_logging.sh
│   ├── 13_nginx_rate_limit.sh
│   ├── 14_fail2ban_nginx.sh
│   └── 99_verify.sh
```

---

## Installation & Ausführung

### 1. Projekt kopieren
```bash
git clone https://github.com/Wenish/teko-cyber-security-raspberry-pi-hardening.git
cd teko-cyber-security-raspberry-pi-hardening
```



### 2. Scripts ausführbar machen (einmalig)
```bash
chmod +x src/harden.sh src/check.sh src/modules/*.sh
```

### 3. Hardening starten
```bash
sudo ./src/harden.sh
```

Nach Abschluss wird ein Reboot empfohlen.

### 4. Hardening Check
```bash
sudo ./src/check.sh
```

oder mit nmap

Wichtig: nmap nur für den Check installieren und danach wieder entfernen.  
Nmap wird ausschliesslich für die Prüfung benötigt und stellt sonst eine zusätzliche Angriffsfläche dar.

```bash
sudo ./src/check.sh --network
```


---

## Umgesetzte Sicherheitsmassnahmen
- System- und Security-Updates (inkl. automatische Updates via unattended-upgrades)
- SSH-Hardening (Key-only, kein Root-Login, Session-Timeouts)
- Firewall (UFW) mit minimalen offenen Ports (SSH, HTTP, HTTPS)
- Schutz vor Brute-Force-Angriffen (Fail2Ban für SSH und Nginx)
- Netzwerk- und Kernel-Hardening (sysctl: SYN-Cookies, IP-Spoofing-Schutz, IPv6 deaktiviert)
- Deaktivierung unnötiger Dienste (Avahi, Bluetooth, CUPS)
- Sudo-Hardening (PTY-Zwang, Logging)
- Persistentes Logging (journald mit Grössenbegrenzung für SD-Karten)
- Nginx Rate-Limiting gegen DoS-Angriffe
- Vorbereitung für sicheren HTTPS-Webserver (Nginx + TLS 1.2/1.3, Security-Header)

---

## Verifikation
Nach der Ausführung überprüft das Script automatisch:
- SSH-Konfiguration
- Firewall-Status
- Fail2Ban-Status

Das `check.sh` Script berechnet einen Hardening-Score (0-10 Punkte) und prüft:
- SSH-Einstellungen (Key-only, Root deaktiviert)
- UFW-Firewall-Status
- Fail2Ban-Status (SSH und Nginx Jails)
- Nginx-Konfiguration und TLS
- Rate-Limiting
- Logging-Konfiguration

Empfohlene manuelle Tests:
- SSH-Login mit Key
- SSH-Login mit Passwort (sollte fehlschlagen)
- nmap-Scan vor und nach dem Hardening
- HTTPS- und WebSocket-Verbindung testen

---

## Hinweise
- Dieses Script dient Lern- und Demonstrationszwecken.
- Es erhebt keinen Anspruch auf vollständige Absicherung.

---
