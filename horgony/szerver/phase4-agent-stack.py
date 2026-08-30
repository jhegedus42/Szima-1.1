#!/usr/bin/env python3
"""Phase 4 validation: agent frameworks, vector DBs, and LiteLLM wiring."""

from __future__ import annotations

import argparse
import os
import sys
import urllib.error
import urllib.request


def check_imports() -> list[str]:
    errors: list[str] = []
    modules = [
        "langchain",
        "langgraph",
        "crewai",
        "autogen",
        "faiss",
        "langchain_openai",
        "chromadb",
        "qdrant_client",
    ]
    for name in modules:
        try:
            __import__(name)
        except ImportError as exc:
            errors.append(f"import {name}: {exc}")
    return errors


def http_ok(url: str, headers: dict[str, str] | None = None) -> tuple[bool, str]:
    req = urllib.request.Request(url, headers=headers or {})
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            body = resp.read(500).decode("utf-8", errors="replace")
            return True, f"HTTP {resp.status}: {body[:200]}"
    except urllib.error.HTTPError as exc:
        body = exc.read(200).decode("utf-8", errors="replace")
        return False, f"HTTP {exc.code}: {body[:200]}"
    except Exception as exc:  # noqa: BLE001
        return False, str(exc)


def check_chromadb(host: str) -> tuple[bool, str]:
    ok, msg = http_ok(f"{host}/api/v2/heartbeat")
    if ok:
        return True, msg
    return http_ok(f"{host}/api/v1/heartbeat")


def check_qdrant(host: str) -> tuple[bool, str]:
    return http_ok(f"{host}/")


def check_faiss() -> tuple[bool, str]:
    import faiss
    import numpy as np

    dim = 8
    index = faiss.IndexFlatL2(dim)
    vectors = np.random.random((3, dim)).astype("float32")
    index.add(vectors)
    _distances, indices = index.search(vectors[:1], 1)
    if indices[0][0] != 0:
        return False, "FAISS nearest-neighbor sanity check failed"
    return True, f"FAISS {faiss.__version__ if hasattr(faiss, '__version__') else 'ok'}"


def check_litellm(
    base_url: str, master_key: str | None, test_invoke: bool = False
) -> tuple[bool, str]:
    if not master_key:
        return True, "skipped (no LITELLM_MASTER_KEY)"

    headers = {"Authorization": f"Bearer {master_key}"}
    ok, msg = http_ok(f"{base_url.rstrip('/')}/v1/models", headers=headers)
    if not ok:
        return False, msg

    if not test_invoke:
        return True, "models endpoint OK (invoke skipped)"

    try:
        from langchain_openai import ChatOpenAI

        model = ChatOpenAI(
            model=os.environ.get("PHASE4_TEST_MODEL", "gemini-1.5-flash"),
            api_key=master_key,
            base_url=f"{base_url.rstrip('/')}/v1",
            timeout=15,
        )
        response = model.invoke("Reply with exactly: phase4-ok")
        text = getattr(response, "content", str(response))
        return True, f"models OK; invoke sample: {str(text)[:120]}"
    except Exception as exc:  # noqa: BLE001
        return False, f"LangChain invoke failed: {exc}"


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate Phase 4 agent stack")
    parser.add_argument("--chromadb-url", default="http://127.0.0.1:8000")
    parser.add_argument("--qdrant-url", default="http://127.0.0.1:6333")
    parser.add_argument("--litellm-url", default="http://127.0.0.1:4000")
    parser.add_argument("--skip-llm", action="store_true")
    parser.add_argument(
        "--test-invoke",
        action="store_true",
        help="Also run a live LangChain invoke (can be slow or fail on provider issues)",
    )
    args = parser.parse_args()

    failures: list[str] = []

    print("== Phase 4: imports ==")
    import_errors = check_imports()
    if import_errors:
        for err in import_errors:
            print(f"FAIL {err}")
            failures.append(err)
    else:
        print("PASS all framework imports")

    print("== Phase 4: ChromaDB ==")
    ok, msg = check_chromadb(args.chromadb_url)
    print(("PASS" if ok else "FAIL"), msg)
    if not ok:
        failures.append(f"chromadb: {msg}")

    print("== Phase 4: Qdrant ==")
    ok, msg = check_qdrant(args.qdrant_url)
    print(("PASS" if ok else "FAIL"), msg)
    if not ok:
        failures.append(f"qdrant: {msg}")

    print("== Phase 4: FAISS ==")
    ok, msg = check_faiss()
    print(("PASS" if ok else "FAIL"), msg)
    if not ok:
        failures.append(f"faiss: {msg}")

    print("== Phase 4: LiteLLM + LangChain ==")
    master_key = None if args.skip_llm else os.environ.get("LITELLM_MASTER_KEY")
    ok, msg = check_litellm(args.litellm_url, master_key, test_invoke=args.test_invoke)
    skipped = msg.startswith("skipped")
    print(("PASS" if ok else "FAIL"), msg)
    if not ok and not skipped:
        failures.append(f"litellm: {msg}")

    if failures:
        print(f"\nPhase 4 validation FAILED ({len(failures)} issue(s))")
        return 1

    print("\nPhase 4 validation PASSED")
    return 0


if __name__ == "__main__":
    sys.exit(main())
