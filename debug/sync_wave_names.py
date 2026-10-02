"""Make the wave's `name`/`title` agree with what the stub actually declares.

The apostrophe migration renamed the declarations and the slugs but left
`name`/`title` holding the old `...'` spelling, so the stub declared
`momPoly_apply_prime` while the wave announced `momPoly_apply'`. The server
rejects apostrophes outright, and even if it did not, the announced name would
not match the declaration being compiled.

The stub is authoritative -- it is the text the server elaborates -- so read the
declaration out of it and use that. Run after any generator change that renames
declarations.
"""
import json
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DECL = re.compile(r"(?m)^[ \t]*(?:noncomputable\s+)?(?:theorem|lemma)\s+"
                  r"([A-Za-z_][\w.']*)")


def main():
    wp = f"{ROOT}/pipeline/wave_upload.json"
    w = json.load(open(wp))
    fixed = []
    for section in ("thms", "defs"):
        for slug, rec in w.get(section, {}).items():
            path = rec.get("file") or ""
            if not path:
                continue
            full = path if os.path.isabs(path) and os.path.exists(path) \
                else f"{ROOT}/{path}"
            if not os.path.exists(full):
                continue
            m = DECL.search(open(full).read())
            if not m:
                continue
            name = m.group(1)
            if "'" in name:
                name = name[:-1] + "_prime"
            if rec.get("name") != name:
                rec["name"] = name
                rec["title"] = f"The Lean 4 theorem `{name.split('.')[-1]}` in the " \
                               f"`{rec.get('chapter', '?')}` chapter of the " \
                               f"timepiece formalization"
                rec["nl"] = (rec.get("nl") or "").replace(
                    f"`{rec.get('name')}`", f"`{name}`")
                fixed.append(f"{section}:{slug}")
    json.dump(w, open(wp, "w"), indent=1)
    left = [s for s, r in list(w["thms"].items()) + list(w["defs"].items())
            if "'" in (r.get("name") or "")]
    print(f"synced {len(fixed)} name(s) from their stubs; "
          f"{len(left)} still carry an apostrophe")


if __name__ == "__main__":
    main()
