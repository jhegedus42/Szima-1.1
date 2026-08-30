# Plan: 1Password MCP + HF token

> NOTE (2026-08-10): Scala is abandoned. Rosetta.scala was DELETED. No new Scala code.
> The Rosetta stone / encoding bridge will be written in IDRIS instead. This plan covers
> only the 1Password MCP + HF token work.

## Context
- 1Password desktop app 8.12.28 running (PID 818). Official stdio MCP server ships at
  `/usr/local/bin/1password-mcp`; toolset is Environments-only (create/rename/list
  environments, append/list variables, local .env files). It never returns secret values.
  Feature must be enabled in-app: Settings → Labs → MCP Server → "Enable local MCP server",
  and Settings → Developer → "Integrate with MCP clients".
- Newly validated HF token: `hf_ELREJTVA_MENTES:/Users/joco/Documents/opencode_mentesek/1pwd-hf-rosetta.md.tokenes` (user jhegedus42 /
  Jozsef Hegedus / jhegedus42@gmail.com, role write). To be stored as a variable in a new
  1Password Environment "huggingface" (account https://huggingface.co/jhegedus42).
- Service account (op CLI) is READ-ONLY — cannot create vault items. So storage path is the
  Environments MCP, NOT op item create.
- `HF_TOKEN` env currently holds an invalid token (`hf_OHXzu...`) sourced from an unknown
  dotfile; grep hits: `~/.secrets`, `~/.local/share/kilo/auth.json`,
  `~/.local/share/opencode/auth.json`, BLACKBOXAI task logs, `~/to_server/old-config/...`.
- Rosetta.scala (Scala 3.6.4) has ~50 compile errors → **DELETED. Abandoned. Use Idris.**

## Tasks

### Task 1 — Wire 1password-mcp into opencode config
Add to `~/.config/opencode/opencode.jsonc` under `mcp`:
```jsonc
"1password": { "type": "local", "command": ["/usr/local/bin/1password-mcp"] }
```
Blocked on: user enabling the two in-app toggles (Labs MCP Server + Developer integrate).
Needs opencode restart to take effect. OWNER: main agent + user.

### Task 2 — Store HF token in a 1Password Environment
After restart + `authenticate`/`list_environments`/`create_environment`, create Environment
"huggingface" and `append_variables`: `HF_TOKEN` = the valid token above. Verify w/
`list_variables` (names only). OWNER: main agent (needs MCP approval prompts in app).

### Task 3 — Fix HF_TOKEN source for the huggingface MCP
After Task 2 stores the token, update whichever file feeds `{env:HF_TOKEN}` (likely
`~/.secrets` or an auth.json) so the remote `https://huggingface.co/mcp?login` MCP
authenticates on opencode restart. Verify: `curl -s https://huggingface.co/api/whoami-v2`
with the token → 200 jhegedus42. OWNER: main agent.

### Task 4 — Rosetta stone in IDRIS (was: fix Rosetta.scala)
**STOPPED / ABANDONED**: Scala is disgusting; we use Idris. Rosetta.scala deleted.
Follow `idris-stilus` load order (MANTRA → HOROG → AGENTS → study `.idr` → write).
The scene: JSON→category→physics cases fed as `String`s; a typed bridge. But only after
the idris-stilus protocol, and only if the user asks. DO NOT resurrect Scala.

### Task 5 — Literature review synthesis (deferred)
scite MCP currently "Unauthorized" for term queries; original 5 searches + DOI list done.
Synthesis + APA References pending. OWNER: main agent, only if scite auth restored.