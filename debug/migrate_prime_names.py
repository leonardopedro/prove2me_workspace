"""Rename the remaining apostrophe slugs to `_prime`.

The server rejects apostrophes in problem names, so every item still carrying
one could never submit -- it just sat in the pending list looking like ordinary
backlog. An earlier pass converted the declaration text but not the slugs, the
wave metadata, the filenames, or the import statements pointing at them, so the
rename was only half done and these survived.

This finishes it everywhere at once: state keys, wave metadata, sol_order,
filenames, and `import Theorems.Thm_<slug>` references. Idempotent.
"""
import json
import os
import re
import subprocess

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def slug_prime(s):
    return s[:-1] + "_prime" if s.endswith("'") else s


def rename_file(path):
    d, base = os.path.split(path)
    if "'" not in base:
        return None
    new = os.path.join(d, base.replace("'", "_prime"))
    if os.path.exists(new):
        os.remove(path)
        return None
    os.rename(path, new)
    return new


def main():
    # 1. state keys
    sp = f"{ROOT}/state/pipeline.json"
    st = json.load(open(sp))
    renamed = 0
    for key in list(st["items"]):
        if "'" in key:
            kind, _, name = key.partition(":")
            st["items"][f"{kind}:{slug_prime(name)}"] = st["items"].pop(key)
            renamed += 1
    json.dump(st, open(sp, "w"), indent=1)

    # 2. wave metadata (thms/defs dicts and sol_order)
    wp = f"{ROOT}/pipeline/wave_upload.json"
    w = json.load(open(wp))
    for section in ("thms", "defs"):
        for key in list(w.get(section, {})):
            if "'" in key:
                rec = w[section].pop(key)
                new = slug_prime(key)
                rec["file"] = (rec.get("file") or "").replace("'", "_prime")
                w[section][new] = rec
                renamed += 1
    if "sol_order" in w:
        w["sol_order"] = [slug_prime(s) for s in w["sol_order"]]
    json.dump(w, open(wp, "w"), indent=1)

    # 3. filenames, then fix imports that point at the old names
    moved = 0
    for sub in ("Theorems", "Solutions"):
        for f in os.listdir(f"{ROOT}/{sub}"):
            if rename_file(f"{ROOT}/{sub}/{f}"):
                moved += 1
    fixed_refs = 0
    for sub in ("Theorems", "Solutions"):
        for f in os.listdir(f"{ROOT}/{sub}"):
            p = f"{ROOT}/{sub}/{f}"
            t = open(p).read()
            n = t.replace("Thm_", "Thm_", 1) and re.sub(
                r"(Thm_[A-Za-z0-9_]+)'", r"\1_prime", t)
            if n != t:
                open(p, "w").write(n)
                fixed_refs += 1
    print(f"prime migration: {renamed} key(s), {moved} file(s) renamed, "
          f"{fixed_refs} stub(s) had import refs rewritten")

    left = subprocess.run(
        ["grep", "-rl", "'", f"{ROOT}/state/pipeline.json",
         f"{ROOT}/pipeline/wave_upload.json"],
        capture_output=True, text=True).stdout.strip()
    print("  residual apostrophes in state/wave:",
          "none" if not left else left)


if __name__ == "__main__":
    main()
