# Phishing Website – INTERNAL Training Tool

This repository contains a simple **internal phishing simulation website** used to test user awareness and observation skills inside a company. The goal is to safely measure how employees react to suspicious login pages and links and to generate data for security awareness reports.

> ⚠️ **Important:** This project is intended **only for authorized internal use** in controlled environments. Do not use it on external users, networks, or domains without explicit written permission.

---

## Features

- Fake login / landing page imitating an internal service.
- Collects:
  - User ID (UID)
  - Entered login/username (no passwords are stored)
  - Click events (buttons, links, elements)
- Logs:
  - `actions.log` – form submissions
  - `clicks.log` – click tracking
- Includes PowerShell script for exporting logs into CSV.

---

## Repository Structure

```
.
├── PHP/
│   ├── index.php
│   ├── submit.php
│   ├── loading.php
│   └── other PHP assets
├── actions.log
├── clicks.log
├── ExportData.csv
├── skrypt.ps1
└── .gitattributes
```

---

## How It Works

1. User receives an internal phishing test link.
2. User opens the PHP landing page.
3. Entered login + UID are logged to `actions.log`.
4. Any clicked element logs an entry in `clicks.log`.
5. `skrypt.ps1` parses logs and generates a CSV summary.

---

## Requirements

- PHP‑enabled webserver (Apache/Nginx/IIS)
- PHP 7.x+
- Write permissions for `.log` files
- PowerShell (optional, for CSV export)

---

## Installation

```bash
git clone https://github.com/wsamselbaudat/Phishing-website-INTERAL.git
```

Copy the `PHP/` directory to your webroot, for example:

```bash
/var/www/html/phishing/
```

Set file permissions:

```bash
chown www-data:www-data actions.log clicks.log
chmod 664 actions.log clicks.log
```

Create a local/internal URL pointing to the phishing directory.

---

## Exporting Data

Run the included PowerShell script:

```powershell
./skrypt.ps1
```

This creates `ExportData.csv` containing parsed logs.

---

## Legal Disclaimer

This tool is intended solely for **authorized internal phishing simulations**.  
Do **not** use it for real phishing attacks or any illegal activity.

---

## Future Enhancements

- Admin dashboard with statistics
- SIEM integration
- Multi-language templates
- Additional phishing page variants

---
