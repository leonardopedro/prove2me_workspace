#!/usr/bin/env python3
"""Third bisect stage: is the drop caused by SirkTrotterKato + StoneBridge?

Both modules that poison a large header import exactly two bundles no passing
module touches (`ChapterSirkTrotterKato`, `ChapterStoneBridge`).  These probes
combine them in every small subset to see which combination discards the header.

Usage: python3 -u debug/probe_sirk_stone.py > state/probe_sirk_stone.log 2>&1 &
"""
import sys
import time

sys.path.insert(0, "pipeline")
import upload_pipeline as up  # noqa: E402

CASES = [
    ["ChapterSirkTrotterKato", "ChapterStoneBridge"],
    ["ChapterSirkTrotterKato", "ChapterQg3DGaugeFarisLavine"],
    ["ChapterStoneBridge", "ChapterQg3DGaugeFarisLavine"],
    ["ChapterSirkTrotterKato", "ChapterStoneBridge", "ChapterQg3DGaugeFarisLavine"],
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
    for mods in CASES:
        tag = "+".join(m[:18] for m in mods)
        jid = submit(mods)
        live[jid] = tag
        print(f"submitted {tag} -> {jid}", flush=True)
    deadline = time.time() + 2400
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
                  + err[:200].replace("\n", " "), flush=True)
            del live[jid]
        if live:
            time.sleep(15)
    for jid, tag in live.items():
        print(f"{tag}: still pending ({jid})", flush=True)


if __name__ == "__main__":
    main()
