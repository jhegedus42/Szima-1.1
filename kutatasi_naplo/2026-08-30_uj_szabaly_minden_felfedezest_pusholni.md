# Kutatási napló — 2026-08-30 (ötödik rész)

## Új hard rule: minden felfedezést push-olni kell

### A felhasználó közlése (szó szerint)

> „fontos szabaly, minden felfedezest push-olni kell !!!"

### Mit tettem

1. **A szabály rögzítve a pluginban** (`~/.config/opencode/AGENTS.md`):
   - **§N13. MINDEN FELFEDEZÉST PUSH-OLNI KELL — HARD RULE.**
   - Minden felfedezés (új eredmény, levezetés, bizonyítás, megértés, kutatási átütés) azonnal commit + push a GitHubra.
   - Nem várunk a „3. prompt ritmusra", nem gyűjtjük felhalmozva — amint egy felfedezés megszületik, azonnal rögzítjük a kutatási naplóba és pusholjuk.
   - A kutatás nem vész el: ha a laptop leáll, a szerver leáll, a context megtelik — a felfedezés a GitHubon marad.
   - Forrás (2026-08-30, a felhasználó): „fontos szabaly, minden felfedezest push-olni kell !!!"
   - A plugin fájl (`~/.config/opencode/AGENTS.md`) frissítve — a §N13 hozzáadva a fájl végéhez, a meglévő §N1–§N12 nem módosítva.

2. **A szabály érvényes minden jövőbeli session-re** — a plugin minden session-be betöltődik.

### Állapot

- A plugin (`~/.config/opencode/AGENTS.md`) frissítve: §N13 hozzáadva
- A `~/.config/opencode/` NEM git-repo, tehát a plugin külön nem pusholható
- De a Szima-1.1 repo-ba másolható a plugin, ha a szerveren is látható kell legyen
- A szabály szerint minden felfedezést pusholni kell — ez a naplóbejegyzés is egy felfedezés (új szabály)