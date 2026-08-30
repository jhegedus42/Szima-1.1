---
name: szerver-ismeret
description: >
  Szerverekkel kapcsolatos fontos tények és hitelesítési adatok.
  Ezeket minden szerver-elérésnél ellenőrizni kell, mert a hostname,
  IP, és SSH aliasok között nincs egyértelmű megfeleltetés.
  Egy szervernek több neve lehet (Hetzner vs SiteGround vs SSH alias).
---

# Szerverek — Fontos Tények és Ellenőrzési Lista

## ⚠️ Figyelmeztetés

**Egy szervernek több neve van. Mindig ellenőrizd, hogy melyik szerveren vagy.**

- Az SSH config (`~/.ssh/config`) aliasai ≠ a tényleges hostname
- Az IP cím ≠ a szolgáltató
- Egy domain (pl. chickenloop.com) más szerveren is futatható

---

## Ismert Szerverek

### 1. 🟢 Chickenloop (SSH alias: `chickenloop`)

**⚠️ EZ NEM A HETZNER SZERVER. EZ A SITEGROUND.**

| Tulajdonság | Érték |
|------------|-------|
| **SSH alias** | `chickenloop` (a `~/.ssh/config`-ból) |
| **SSH cím** | `ssh.chickenloop.com:18765` |
| **Felhasználó** | `u44-lsefuz8uidbg` |
| **Tényleges hostname** | `gtxm1079.siteground.biz` |
| **Szolgáltató** | **SiteGround** (shared hosting) |
| **OS** | Fedora Linux 43 (kernel 6.12.91) |
| **IP** | 88.99.218.155 (SiteGround IP) |
| **Elérés** | `ssh -p 18765 u44-lsefuz8uidbg@ssh.chickenloop.com` |
| **Kulcs** | `~/.ssh/chickenloop_new` |

**Mit futtat:**
- Drupal weboldal: `chickenloop.com`
- Cursor IDE távoli szerver: `.cursor-server/`
- AI projekt archívum: `agi_Jul25.zip` (610 MB)
- Adatbázis dump: `zondalin_chickenloop.sql` (227 MB)

**Fontos:**
- `ps` parancs nincs (chroot/shared hosting)
- `docker` nincs
- root hozzáférés korlátozott (chroot)
- A `/home/customer/` a saját könyvtár

---

### 2. 🔴 Hetzner Szerver (IP: 88.99.218.155)

**⚠️ FIGYELEM: A 88.99.218.155 IP a Hetzner-hez tartozik, de a `chickenloop` alias a SiteGround-ra mutat!**

| Tulajdonság | Érték |
|------------|-------|
| **IP** | `88.99.218.155` |
| **Szolgáltató** | **Hetzner** |
| **Elérés** | `ssh root@88.99.218.155` |
| **Státusz** | ❌ Nincs működő SSH kulcs jelenleg |
| **Hiba** | "Too many authentication failures" |

**Lehetséges kulcsok:**
- `~/.ssh/id_ed25519` → Permission denied
- `~/.ssh/id_rsa` → Permission denied  
- `~/.ssh/id_github` → Permission denied

**Teendő:** Ha hozzáférés kell, jelszavas bejelentkezés vagy megfelelő kulcs szükséges.

---

## Ellenőrzési Protokoll Minden Szerver-Elérésnél

Mielőtt bármit csinálsz egy szerveren:

```
1. Ellenőrizd: ssh -p <port> <user>@<host> "whoami && hostname && uname -a"
2. Ellenőrizd: Ez tényleg a szerver amire gondoltál?
3. Ellenőrizd: A Hetzner vagy a SiteGround?
4. Ellenőrizd: Mit futtat ez a szerver?
5. Ellenőrizd: Mi van a home könyvtárban?
```

**Ha nem vagy biztos: KÉRDEZZ, ne tételezz fel.**

---

## Szerverek Közötti Különbségek

| Tulajdonság | SiteGround (Chickenloop) | Hetzner |
|------------|--------------------------|---------|
| Típus | Shared hosting | Dedikált/VPS |
| root hozzáférés | Korlátozott (chroot) | Teljes |
| Docker | ❌ Nincs | ✅ Lehet |
| ps/top | ❌ Nincs | ✅ Van |
| OS | Fedora 43 | ??? (nem ismert) |
| Használat | Weboldal, Cursor IDE, AI archívum | ??? (nem ismert) |

---

## Történelmi Események

- **2026-08-04**: A `/Z` könyvtár létrejött a SiteGround szerveren (üres)
- **2026-07-25**: `agi_Jul25.zip` létrejött (610 MB — AI projekt archívum)
- **2026-02-14**: Legutóbbi `.bash_history` bejegyzés

---

## Biztonsági Megjegyzések

- **NE** írj a szerverre engedély nélkül (AGENTS.md szabály #1)
- **NE** törölj semmit a szerverről
- Olvasás rendben — de mindig jegyezd fel mit láttál
- A kulcsok (`~/.ssh/*`) NE kerüljenek a git-be
- A `agi_Jul25.zip` és hasonló archívumok NAGYOK — ne töltsd le helyből

---

## Frissítési Napló

- **2026-08-04**: Skill létrehozva. SiteGround és Hetzner szerverek dokumentálva.
- **TODO**: Hetzner szerver részleteit pótolni, ha lesz hozzáférés.
