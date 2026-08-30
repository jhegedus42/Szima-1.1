---
name: git-push
description: >
  Git push skill — mindent feltolt a gitre: kod, skill-ek, konyvek, logok, indexelesek.
  A git a szivdobbanas — minden 3. szivdobbanasnal commit + push.
  Soha nincs destruktiv operacio (nincs reset, rebase, force push).
---

# Git Push Skill

## Használat

```
skill git-push
```

## Szabályok

1. **Soha nincs destruktiv operacio** — nincs `git reset`, `rebase`, `force push`
2. **Csak adj hozza** — `git add -A && git commit && git push`
3. **Minden 3. szivdobbanasnal** — commit + push (~15 perc)
4. **Magyar commit uzenetek** — magyarul, roviden, leiroan
5. **Ne commitolj titkokat** — .env, credentials, recovery phrase-ok

##rutin

```bash
# 1. Status ellenorzese
git status

# 2. Mindent hozzaadas
git add -A

# 3. Commit magyarul
git commit -m "leiras: mi tortent"

# 4. Push
git push
```

## Mit kell feltolni

| Mit | Hova | Miert |
|-----|------|-------|
| Idris kod (.idr) | `osveny_index/` | A rendszer magja |
| Skill-ek (SKILL.md) | `~/.agents/skills/` + git | Minden skill |
| Konyvek (.tex, .pdf) | `konyv.tex`, `konyv.pdf` | A generalt konyv |
| Logok | `session-*.md` | Session exportok |
| Indexelesek | `trail_index/` | Konyv indexelesek |
| Adatbazis export | `why-chain.jsonl` | Why-chain memoriaba |

## Skill-ek szinkronizalasa

A skill-ek a `~/.agents/skills/` konyvtarban vannak, de a git repo-ba is masoljuk oket:

```bash
# Skill-ek masolasa a git repoba
mkdir -p skills
cp -r ~/.agents/skills/* skills/

# Git add + commit + push
git add -A && git commit -m "skill-ek szinkronizalasa" && git push
```

## .gitignore szabalyok

```
session-*.md
trail_index/build/
*.log
*.aux
*.out
*.toc
```

## Ellenorzes

```bash
# Mik nem folynak
git status --porcelain

# Utolso commitok
git log --oneline -10

# Remote status
git remote -v
```