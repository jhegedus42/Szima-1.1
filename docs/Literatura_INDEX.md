# Literatúra index — gyors belépés

## Olvasás (válassz egyet)

| Hol | Link |
|-----|------|
| **Böngésző (diagramokkal)** | [literatura.html](./literatura.html) — helyi vagy GitHub Pages |
| **GitHub markdown** | [Literatura_Terkep_Teljes.md](https://github.com/jhegedus42/Szima/blob/cursor/literature-aaa6/docs/Literatura_Terkep_Teljes.md) |
| **Élő oldal (Pages után)** | `https://jhegedus42.github.io/Szima/literatura.html` |

### GitHub Pages (egyszer beállítani)

1. [Szima → Settings → Pages](https://github.com/jhegedus42/Szima/settings/pages)
2. **Build and deployment → Source:** GitHub Actions
3. Merge / push a `cursor/literature-aaa6` ágra → workflow fut → oldal él

### Vercel — ág-specifikus preview (ajánlott)

**[VERCEL_AG_DOCS.md](./VERCEL_AG_DOCS.md)** — teljes útmutató.

- Import repo → gyökér `vercel.json` (build: `docs/scripts/vercel-build.sh`, output: `docs`)
- **Production:** `master` → fő domain
- **Minden más ág** → saját preview URL (`*-git-<ág>-*.vercel.app`)
- Alján branch banner (ág neve + commit)

### Cloudflare Pages

Ugyanaz: output `docs`, build script `bash docs/scripts/vercel-build.sh`, preview branches: all.

---

## Dokumentumok

| Dokumentum | Mi ez? |
|------------|--------|
| **[Literatura_Terkep_Teljes.md](./Literatura_Terkep_Teljes.md)** | Teljes térkép, mermaid diagramok, navigáció |
| **[literatura.html](./literatura.html)** | Ugyanaz vizuálisan (Mermaid CDN) |
| **[adatok/literatura_index.json](./adatok/literatura_index.json)** | Gépi index (JSON) |
| [archivum_terkep.md](./archivum_terkep.md) | Kimi / HANMAG transcriptek |
| [KonyvKivonat_Awodey.md](./KonyvKivonat_Awodey.md) | Awodey kivonat |
| [KonyvKivonat_MacLane.md](./KonyvKivonat_MacLane.md) | Mac Lane kivonat |

**Ág:** `cursor/literature-aaa6` — csak dokumentáció, nem módosítja a fő Idris kódot.
