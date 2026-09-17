#!/usr/bin/env python3
"""Find already-Proved platform theorems reusable on the timepiece NS/QG route.

Read-only.  Searches the live catalogue by keyword (title/name/natural-language)
with status=Proved, and groups the hits by author so a plan can cite a theorem
"from another user" as an external assumption / platform import.

Usage:
    python3 debug/find_reusable_proved.py            # default keyword set
    python3 debug/find_reusable_proved.py --q kato --q friedrichs
    python3 debug/find_reusable_proved.py --show-stmt   # print formal statements
"""
import argparse
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

DEFAULT_QUERIES = [
    "Faris-Lavine",
    "essential self-adjoint",
    "essentially self-adjoint",
    "Friedrichs extension",
    "self-adjoint extension",
    "Fock space",
    "second quantization",
    "differential second quantization",
    "Kato-Rellich",
    "relatively bounded",
    "Friedrichs inequality",
    "Plancherel",
    "Fourier multiplier",
    "convolution",
    "sum of squares",
    "Navier-Stokes",
    "self-adjoint operator",
    "Schur test",
    "form domain",
    "quadratic form",
]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--q", action="append", default=None)
    ap.add_argument("--limit", type=int, default=50)
    ap.add_argument("--show-stmt", action="store_true")
    args = ap.parse_args()
    queries = args.q or DEFAULT_QUERIES

    ok, version, detail = up.auth_probe()
    print(f"auth ok={ok} platform_version={version} {detail}")
    if not ok:
        return 2

    me = up.api("GET", "me") or {}
    my_id = me.get("user_id") or me.get("id")
    my_name = me.get("username") or me.get("name")
    print(f"me: {my_name} ({my_id})\n")

    seen = {}
    for q in queries:
        body = up.api("GET", "theorems",
                      params={"status": "Proved", "q": q, "limit": args.limit})
        rows = (body or {}).get("theorems") or []
        print(f"=== q={q!r}: {len(rows)} shown / total={(body or {}).get('total')} ===")
        for r in rows:
            tid = r.get("theorem_id")
            if tid in seen:
                continue
            seen[tid] = r
            author = r.get("created_by_username")
            mine = "SELF" if r.get("created_by") == my_id else f"other:{author}"
            print(f"  [{mine}] {r.get('theorem_name')}")
            if args.show_stmt:
                stmt = (r.get("formal_statement") or "").replace("\n", " ")
                print(f"        {stmt[:400]}")
        print()

    print(f"\n{len(seen)} distinct Proved theorems across {len(queries)} queries")
    others = [r for r in seen.values() if r.get("created_by") != my_id]
    by_author = {}
    for r in others:
        by_author.setdefault(r.get("created_by_username"), []).append(r)
    print("\n-- by other user --")
    for a, rs in sorted(by_author.items(), key=lambda kv: -len(kv[1])):
        print(f"  {a}: {len(rs)}")
        for r in rs:
            print(f"      {r.get('theorem_name')}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
