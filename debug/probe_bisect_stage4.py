#!/usr/bin/env python3
"""Fourth bisect stage: is the drop monotone in cost, or cold-cache (retry-fixable)?

Three probes:
  * the failing pair again -- if a retry now inlines, the first run merely paid a
    cold build and a plain resubmit is the repair;
  * the failing pair plus one more module -- strictly heavier: a success here
    rules the cumulative-cost theory out;
  * the real 3-import header of `BookProof/Sm/ChapterSmFockEsa.lean`.

Usage: python3 -u debug/probe_bisect_stage4.py > state/probe_stage4.log 2>&1 &
"""
import sys
import time

sys.path.insert(0, "pipeline")
import upload_pipeline as up  # noqa: E402

CASES = [
    ["ChapterSmComparisonEsa", "ChapterQg3DGaugeFarisLavine"],
    ["ChapterSmComparisonEsa", "ChapterQg3DGaugeFarisLavine", "ChapterQgOuterFockFullFL"],
    ["ChapterSmOuterFock", "ChapterSmComparisonEsa", "ChapterYangMillsNonAbelianEsa"],
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
    for i, mods in enumerate(CASES, 1):
        tag = f"case{i}: " + "+".join(m[:14] for m in mods)
        jid = submit(mods)
        live[jid] = tag
        print(f"{tag} -> {jid}", flush=True)
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
                  + err[:160].replace("\n", " "), flush=True)
            del live[jid]
        if live:
            time.sleep(15)


if __name__ == "__main__":
    main()
