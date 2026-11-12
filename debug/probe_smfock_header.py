#!/usr/bin/env python3
"""Bisect which import in a definition header makes the platform drop the header.

Background job: submits every probe up front (the platform queues them), then
polls.  Diagnostics only -- each probe deliberately fails to compile, so nothing
is published; the signal is whether the compiler saw `MvPolynomial`/`Nat`
(header inlined) or reported them unknown (header discarded).

Usage: python3 debug/probe_smfock_header.py > state/probe_bisect.log 2>&1 &
"""
import sys
import time

sys.path.insert(0, "pipeline")
import upload_pipeline as up  # noqa: E402

BASE = ["ChapterSmComparisonEsa"]
EXTRA = [
    "ChapterQg3DGaugeFarisLavine",
    "ChapterQgOuterFockFullFL",
    "ChapterSqSumFarisLavine",
    "ChapterSqSumOuterFamily",
    "ChapterYangMillsFockFriedrichs",
]


def submit(mods):
    body = "\n".join("import Definitions.Def_" + m for m in mods)
    body += "\n\nopen MvPolynomial\n\ndef probeSubset : (1 : Nat) = 2 := rfl\n"
    r = up.api("POST", "submit-definition", {
        "definition_name": "ChapterSmFockEsa",
        "definition_title": "probe: header bisect",
        "definition": body,
        "natural_language_statement": "Diagnostic probe; not publishable.",
        "source": "probe",
        "tags": ["probe"],
    })
    return ((r or {}).get("jobs") or [{}])[0].get("job_id") or (r or {}).get("job_id")


def main():
    live = {}
    for m in EXTRA:
        jid = submit(BASE + [m])
        live[jid] = m
        print(f"submitted {m} -> {jid}", flush=True)
    seen = set()
    deadline = time.time() + 1500
    while live and time.time() < deadline:
        for jid, tag in list(live.items()):
            p = up.api("GET", f"publish-jobs/{jid}", None) or {}
            st = p.get("status")
            if st not in ("PUBLISHED", "FAILED", "ERROR"):
                continue
            err = str(p.get("error_message"))
            dropped = ("unknown namespace `MvPolynomial`" in err
                       or "Unknown identifier `Nat`" in err
                       or "unknown namespace `BookProof`" in err)
            print(f"{tag}: header={'DROPPED' if dropped else 'ok'}  "
                  + err[:160].replace("\n", " "), flush=True)
            if dropped:
                seen.add(tag)
            del live[jid]
        if live:
            time.sleep(15)
    for jid, tag in live.items():
        print(f"{tag}: still pending ({jid})", flush=True)
    print("culprits:", sorted(seen) or "none among the five", flush=True)


if __name__ == "__main__":
    main()
