#!/usr/bin/env python3
"""Extend pipeline/wave_upload.json with the upstream-def publication wave.

Adds:
  * def entries for the 70 chapters in debug/upstream_list.txt (66 upstream
    def bundles + the 4 deferred chapters' def bundles, incl. SirkPerSystem
    aggregation), same entry schema as the existing entries.
  * thm + sol entries for the 4 deferred chapters
    (SirkEndToEnd, SirkWhitening, SirkPerSystem, YangMillsHermite), whose
    thm/sol stubs already exist in Theorems/ + Solutions/.

Def publish order is computed at runtime by upload_pipeline.py
(topological_def_order from `import Definitions.Def_*` lines), so this script
only extends the JSON.  Append-only: existing entries are never removed.
"""
import collections
import glob
import json
import os
import re

WS = "/home/leo/prove2me_workspace"
REPO = "https://github.com/leonardopedro/timepiece/blob/61595bc"
PIPE = f"{WS}/pipeline/wave_upload.json"

DEFERRED = ["ChapterSirkEndToEnd", "ChapterSirkWhitening",
            "ChapterSirkPerSystem", "ChapterYangMillsHermite"]

DOMAIN = [
    ("Stone", ["stone-theorem", "spectral-theory"]),
    ("YangMills", ["qym", "yang-mills"]),
    ("NavierStokes", ["navier-stokes", "operator-algebras"]),
    ("Sirk", ["sirk", "spectral-theory"]),
    ("Hermite", ["hermite", "special-functions"]),
    ("FarisLavine", ["faris-lavine", "spectral-theory"]),
    ("KatoRellich", ["kato-rellich", "spectral-theory"]),
    ("EsaClosure", ["esa", "spectral-theory"]),
    ("QuantumGravity", ["quantum-gravity"]),
    ("Starobinsky", ["quantum-gravity", "cosmology"]),
    ("Weyl", ["qym", "yang-mills"]),
    ("ComplexShift", ["hashimoto", "sirk"]),
    ("Hashimoto", ["hashimoto", "sirk"]),
    ("ContinuityUnitary", ["unitary", "spectral-theory"]),
    ("Unitary", ["unitary", "spectral-theory"]),
    ("Strichartz", ["wave", "spectral-theory"]),
    ("DoubleSlit", ["quantum-gravity"]),
    ("FreeField", ["quantum-gravity", "gauge-theory"]),
    ("Trajectory", ["navier-stokes"]),
    ("U", ["unitary", "spectral-theory"]),
    ("UnboundedPosition", ["operator-algebras"]),
    ("WaveBoundedPotential", ["wave", "spectral-theory"]),
    ("HyperbolicQuadraticEsa", ["esa", "spectral-theory"]),
]


def chapter_tags(chap):
    tags = ["timepiece"]
    for prefix, extra in DOMAIN:
        if prefix in chap:
            tags += extra
            break
    if chap.startswith("ChapterH") or chap == "ChapterH8Bases":
        tags += ["hashimoto", "sirk"]
    return list(dict.fromkeys(tags))


def module_doc(path):
    txt = open(path, encoding="utf-8").read()
    m = re.search(r"/-!\n(.*?)-/", txt, re.S)
    return m.group(1).strip() if m else ""


def clean_paras(doc):
    paras = [re.sub(r"\s+", " ", p).strip() for p in doc.split("\n\n")]
    return [p for p in paras if p and not p.startswith("#")]


def def_meta(chap):
    leaf = chap[7:]
    path = f"{WS}/Definitions/Def_{chap}.lean"
    doc = module_doc(path)
    paras = clean_paras(doc)
    title = paras[0] if paras else chap
    if len(title) > 120:
        title = title[:120].rstrip() + " ..."
    lead = (f"Formal definitions for the timepiece Lean 4 formalization "
            f"(module `BookProof.{leaf}`, source chapter "
            f"`BookProof/Chapter{leaf}.lean`).")
    nl = lead + ("\n\n" + "\n\n".join(paras) if paras else "")
    if len(nl) > 4000:
        nl = nl[:4000].rstrip() + "\n\n..."
    return {
        "definition_name": chap,
        "namespace": f"BookProof.{leaf}",
        "file": path,
        "title": title,
        "nl": nl,
        "source": f"{REPO}/BookProof/Chapter{leaf}.lean",
        "tags": chapter_tags(chap),
    }


def thm_meta(slug):
    """Node metadata from the Thm stub file (name + statement-derived NL)."""
    path = f"{WS}/Theorems/Thm_{slug}.lean"
    txt = open(path, encoding="utf-8").read()
    m = re.search(r"^theorem\s+([A-Za-z0-9_.]+)\s+(.*?)(?::=)", txt, re.M | re.S)
    name = m.group(1) if m else slug.replace("_", ".")
    stmt = re.sub(r"\s+", " ", m.group(2)).strip() if m else ""
    if len(stmt) > 300:
        stmt = stmt[:300].rstrip() + " ..."
    leaf = slug.split("_")[1] if "_" in slug else ""
    return {
        "name": name,
        "file": path,
        "title": stmt or name,
        "nl": (f"Lean 4 theorem `{name}` (module `BookProof.{leaf}`), source "
               f"chapter `BookProof/Chapter{leaf}.lean`."),
        "source": f"{REPO}/BookProof/Chapter{leaf}.lean",
        "tags": chapter_tags(f"Chapter{leaf}"),
    }


def main():
    wave = json.load(open(PIPE, encoding="utf-8"))
    chaps = [l.strip() for l in open(f"{WS}/debug/upstream_list.txt")
             if l.strip()]
    for chap in chaps:
        if chap not in wave["defs"]:
            wave["defs"][chap] = def_meta(chap)

    sol_files = sorted(glob.glob(f"{WS}/Solutions/Sol_BookProof_*.lean"))
    sol_files = [p for p in sol_files
                 if any((f"Chapter{d[7:]}_" in os.path.basename(p)) or
                        (f"_{d[7:]}_" in os.path.basename(p))
                        for d in DEFERRED)]
    alln = {os.path.basename(p)[len("Sol_"):-len(".lean")] for p in sol_files}
    adj = collections.defaultdict(set)
    indeg = collections.defaultdict(int)
    for p in sol_files:
        slug = os.path.basename(p)[len("Sol_"):-len(".lean")]
        for dep in re.findall(r"import Theorems\.Thm_(\S+)",
                              open(p, encoding="utf-8").read()):
            assert dep != slug, f"self import in {slug}"
            adj[dep].add(slug)
            indeg[slug] += 1
    q = collections.deque(sorted(s for s in alln if indeg[s] == 0))
    order = []
    while q:
        s = q.popleft()
        order.append(s)
        for m in sorted(adj[s]):
            indeg[m] -= 1
            if indeg[m] == 0:
                q.append(m)
    assert len(order) == len(alln), f"cycle: {sorted(alln - set(order))}"

    # Drop any pre-existing deferred entries from sol_order so the fresh
    # topological order of the 82 deferred solutions is appended cleanly.
    pre = [s for s in wave["sol_order"]
           if not any(f"Chapter{d[7:]}" in s or f"_{d[7:]}_" in s
                      for d in DEFERRED)]
    wave["sol_order"] = pre
    for slug in order:
        if slug not in wave["thms"]:
            wave["thms"][slug] = thm_meta(slug)
        wave["sol_order"].append(slug)

    with open(PIPE, "w", encoding="utf-8") as f:
        json.dump(wave, f, indent=1)
    print(f"defs: {len(wave['defs'])}  thms: {len(wave['thms'])}  "
          f"sol_order: {len(wave['sol_order'])}")


if __name__ == "__main__":
    main()