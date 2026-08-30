#!/usr/bin/env python3
"""Export Claude Code JSONL session to structured conversation log."""
import json, os, sys, re
from datetime import datetime, timezone
from pathlib import Path

PROJECT_DIR = os.path.expanduser("~/.claude/projects/-home-joco-claude")
MEMORY_DIR = os.path.expanduser("~/memory")
FLEET_OPS = os.path.join(MEMORY_DIR, "FLEET_OPS.md")


def detect_context(session_data: list) -> dict:
    """Detect agent, environment, model from session hints."""
    ctx = {"agent": "unknown", "env": "unknown", "model": "unknown",
           "title": "Untitled", "files_touched": set(), "tool_counts": {},
           "user_messages": 0, "assistant_messages": 0, "total_tokens": 0}
    for line in session_data:
        try:
            ev = json.loads(line) if isinstance(line, str) else line
        except json.JSONDecodeError:
            continue
        t = ev.get("type", "")
        if t == "ai-title":
            ctx["title"] = ev.get("content", "Untitled")
        elif t == "assistant":
            msg = ev.get("message", {})
            ctx["assistant_messages"] += 1
            ctx["model"] = msg.get("model", ctx["model"])
            for usage_field in ("usage", "usage_info"):
                if usage_field in msg:
                    ctx["total_tokens"] += msg[usage_field].get("input_tokens", 0) + msg[usage_field].get("output_tokens", 0)
            for content in msg.get("content", []):
                if content.get("type") == "tool_use":
                    tn = content.get("name", "?")
                    ctx["tool_counts"][tn] = ctx["tool_counts"].get(tn, 0) + 1
                    inp = content.get("input", {})
                    if "file_path" in inp:
                        ctx["files_touched"].add(inp["file_path"])
        elif t == "user":
            ctx["user_messages"] += 1
    # detect environment
    ctx["env"] = "jail (CJN)" if os.path.exists("/.dockerenv") else "host (CLA, GON pattern)"
    ctx["agent"] = "CLA" if ctx["env"].startswith("jail") else "CLA (host mode)"
    return ctx


def generate_log(session_data: list, ctx: dict, sid: str) -> str:
    """Generate structured markdown log."""
    now = datetime.now(timezone.utc)
    date_str = now.strftime("%Y-%m-%d")
    ts = now.strftime("%Y-%m-%d %H:%M UTC")

    lines = [
        f"# Session: {ctx['title']}",
        f"**Dátum:** {date_str} | **ID:** {sid[:12]}",
        f"**Agent:** {ctx['agent']} | **Modell:** {ctx['model']} | **Környezet:** {ctx['env']}",
        f"**Üzenetek:** {ctx['user_messages']} kérdés, {ctx['assistant_messages']} válasz | **Token:** ~{ctx['total_tokens']:,}",
        "",
        "---",
        "",
        "## Tool használat",
    ]
    for tool, count in sorted(ctx["tool_counts"].items(), key=lambda x: -x[1]):
        lines.append(f"- `{tool}`: {count}×")

    if ctx["files_touched"]:
        lines.append("")
        lines.append("## Érintett fájlok")
        for f in sorted(ctx["files_touched"]):
            lines.append(f"- `{f}`")

    lines.extend([
        "",
        "## Meta",
        f"- Teljes transcript: `{PROJECT_DIR}/{sid}.jsonl`",
        f"- FLEET_OPS: `{FLEET_OPS}`",
        f"- Export idő: {ts}",
        "",
        "---",
        f"> Auto-export by export-session.py. Session ID: {sid}",
        "",
    ])
    return "\n".join(lines)


def main():
    sid = sys.argv[1] if len(sys.argv) > 1 else None
    if not sid:
        # find latest session
        files = sorted(Path(PROJECT_DIR).glob("*.jsonl"), key=lambda p: p.stat().st_mtime, reverse=True)
        if not files:
            print("No sessions found", file=sys.stderr)
            sys.exit(1)
        sid = files[0].stem

    session_file = os.path.join(PROJECT_DIR, sid + ".jsonl")
    if not os.path.exists(session_file):
        print(f"Session not found: {session_file}", file=sys.stderr)
        sys.exit(1)

    with open(session_file) as f:
        session_data = f.readlines()

    ctx = detect_context(session_data)
    log = generate_log(session_data, ctx, sid)
    date_str = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    log_file = os.path.join(MEMORY_DIR, f"conversation-log-{date_str}.md")

    # append mode if file exists for today
    mode = "a" if os.path.exists(log_file) else "w"
    with open(log_file, mode) as f:
        f.write(log + "\n")

    print(f"Exported {len(session_data)} events → {log_file}")
    print(f"  Agent: {ctx['agent']} | Model: {ctx['model']} | Env: {ctx['env']}")
    print(f"  Tools: {sum(ctx['tool_counts'].values())} calls | Files: {len(ctx['files_touched'])} | Tokens: {ctx['total_tokens']:,}")


if __name__ == "__main__":
    main()
