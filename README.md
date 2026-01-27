# Raspberry Pi OS Hardening Script

## Beschreibung
Dieses Projekt stellt ein automatisiertes Hardening-Script für Raspberry Pi OS zur Verfügung.  
Das Script härtet ein frisch installiertes System, ohne die Funktionalität als Webserver einzuschränken.

Nach der Ausführung sind folgende Funktionen weiterhin möglich:
- SSH-Zugriff ausschliesslich per SSH-Key
- Betrieb als Webserver mit HTTPS
- Sichere WebSocket-Verbindungen (WSS)

Das Hardening erfolgt modular und reproduzierbar.

---

## Ziel
Ziel dieses Projekts ist es, die Angriffsfläche eines Raspberry Pi zu reduzieren und gängige Sicherheitsrisiken zu minimieren, ohne produktive Dienste zu blockieren.

---

## Voraussetzungen
- Raspberry Pi 5
- Raspberry Pi OS (Bullseye oder Bookworm)
- Internetverbindung
- Bestehender SSH-Key für den Benutzer
- Root-Rechte (sudo)

**Wichtig:**  
Vor der Ausführung muss sichergestellt sein, dass mindestens ein SSH-Key eingerichtet ist.  
Andernfalls ist nach dem Hardening kein SSH-Zugriff mehr möglich.

---

## Projektstruktur

```text
hardening/
├── harden.sh
├── modules/
│   ├── 01_update_system.sh
│   ├── 02_users_ssh.sh
│   ├── 03_firewall.sh
│   ├── 04_fail2ban.sh
│   ├── 05_sysctl.sh
│   ├── 06_nginx_tls.sh
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
chmod +x main.sh modules/*.sh
```

### 3. Hardening starten
```bash
sudo ./main.sh
```

Nach Abschluss wird ein Reboot empfohlen.

---

## Umgesetzte Sicherheitsmassnahmen
- System- und Security-Updates
- SSH-Hardening (Key-only, kein Root-Login)
- Firewall (UFW) mit minimalen offenen Ports
- Schutz vor Brute-Force-Angriffen (Fail2Ban)
- Netzwerk- und Kernel-Hardening (sysctl)
- Vorbereitung für sicheren HTTPS-Webserver (Nginx + TLS)

---

## Verifikation
Nach der Ausführung überprüft das Script automatisch:
- SSH-Konfiguration
- Firewall-Status
- Fail2Ban-Status

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
