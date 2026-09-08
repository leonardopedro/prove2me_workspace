#!/usr/bin/env python3
"""Assemble pipeline/wave_upload.json for the uploader (Phase 6).

Reads state/wave_manifest.json (slug -> dotted name + chapter leaf) and
state/wave_meta.json (per-node titles/NL/tags/source), extracts the 7 chapter
Def-bundle docstrings for definition metadata, and computes the topological
solution order from the import statements inside Solutions/Sol_BookProof_*.lean
(imported theorems must be published+proved before the importing solution).

Output: pipeline/wave_upload.json
  {
    "defs":     { "<ChapterName>": {definition_name, file, title, nl, source, tags} },
    "thms":     { "<slug>": {name, file, title, nl, source, tags} },
    "sol_order":[ "<slug>", ... ]          # dependencies first (leaves -> roots)
  }
"""
import collections
import glob
import json
import os
import re

WS = "/home/leo/prove2me_workspace"
REPO = "https://github.com/leonardopedro/timepiece/blob/61595bc"
CHAPTER = {
    "ChapterMassGap": {"title": "Mass-gap algebra: shifted spectrum and vacuum observables",
                       "tags": ["timepiece", "qym", "mass-gap", "operator-algebras"]},
    "ChapterBRSTNilpotent": {"title": "Nilpotency of the pure-SU(3) BRST charge",
                             "tags": ["timepiece", "qym", "brst", "gauge-theory"]},
    "ChapterGhostField": {"title": "Ghost field and BRST charge for Navier-Stokes",
                          "tags": ["timepiece", "navier-stokes", "ghost-field", "brst"]},
    "ChapterNavierStokes": {"title": "Navier-Stokes ghost CAR algebra",
                            "tags": ["timepiece", "navier-stokes", "operator-algebras"]},
    "ChapterGaugeFixing": {"title": "BRST doublets and the gauge-fixing fermion",
                           "tags": ["timepiece", "gauge-fixing", "brst"]},
    "ChapterSirkFinitePrecision": {"title": "SIRK finite-precision certificate layer (T1-T5)",
                                   "tags": ["timepiece", "sirk", "certified-gap", "spectral-theory"]},
    "ChapterYangMillsFieldStrength": {"title": "Non-abelian field strength and magnetic field",
                                      "tags": ["timepiece", "qym", "yang-mills"]},
    "ChapterBaryonAsymmetry": {"title": "Baryon asymmetry and baryon-number observables",
                               "tags": ["timepiece", "qym", "baryon-asymmetry"]},
    "ChapterMajoranaClifford": {"title": "Majorana Clifford algebra",
                                "tags": ["timepiece", "qym", "majorana", "clifford-algebra"]},
    "ChapterMajoranaProp61": {"title": "Majorana properties 61",
                              "tags": ["timepiece", "qym", "majorana"]},
    "ChapterMajoranaProp76": {"title": "Majorana properties 76",
                              "tags": ["timepiece", "qym", "majorana"]},
    "ChapterParityMajoranaQuant": {"title": "Parity and Majorana quantization",
                                   "tags": ["timepiece", "qym", "parity", "majorana"]},
    "ChapterYangMillsBianchi": {"title": "Yang-Mills Bianchi identity",
                                "tags": ["timepiece", "qym", "yang-mills", "bianchi"]},
    "ChapterYangMillsSU3": {"title": "SU(3) structure constants",
                            "tags": ["timepiece", "qym", "su3", "structure-constants"]},
    "ChapterSirkGroupTransfer": {"title": "One-parameter group transfer",
                                 "tags": ["timepiece", "sirk", "groups"]},
}

# Targets from these folders must additionally pass the Phase-0 soundness gate:
# sorry-free and no axioms beyond {propext, Classical.choice, Quot.sound}.
# (Run `lake env lean axiom_gate.lean` in /home/leo/Projects/timepiece; a target
# is only usable if it prints OK and its meta carries axiom_clean/sorry_free.)
STRICT_FOLDERS = ("/PnpProof/", "/UsedRoute/", "/UnusedRoute/")


def require_gate(src, meta):
    if any(f in src for f in STRICT_FOLDERS):
        assert meta.get("axiom_clean") is True, \
            f"strict-folder target lacks axiom_clean (Phase-0 gate): {src}"
        assert meta.get("sorry_free") is True, \
            f"strict-folder target lacks sorry_free: {src}"


# Node tags default: chapter tags; override common domain tags per node below
NODE_EXTRA = {
    "BookProof_SirkFinitePrecision_": ["sirk", "certified-gap", "spectral-theory"],
    "BookProof_MassGap_": ["qym", "mass-gap", "operator-algebras"],
    "BookProof_YangMillsFieldStrength_": ["qym", "yang-mills"],
    "BookProof_BRSTNilpotent_": ["qym", "brst"],
    "BookProof_GhostField_": ["navier-stokes", "ghost-field", "brst"],
    "BookProof_NavierStokes_": ["navier-stokes"],
    "BookProof_GaugeFixing_": ["gauge-fixing", "brst"],
    "BookProof_BaryonAsymmetry_": ["qym", "baryon-asymmetry"],
    "BookProof_MajoranaClifford_": ["qym", "majorana", "clifford-algebra"],
    "BookProof_MajoranaProp61_": ["qym", "majorana"],
    "BookProof_MajoranaProp76_": ["qym", "majorana"],
    "BookProof_ParityMajoranaQuant_": ["qym", "parity", "majorana"],
    "BookProof_YangMillsBianchi_": ["qym", "yang-mills", "bianchi"],
    "BookProof_YangMillsSU3_": ["qym", "su3", "structure-constants"],
    "BookProof_SirkGroupTransfer_": ["sirk", "groups"],
}


def dedupe(seq):
    out = []
    for x in seq:
        if x not in out:
            out.append(x)
    return out


def module_docstring(path):
    txt = open(path, encoding="utf-8").read()
    m = re.search(r"/-!\n(.*?)-/", txt, re.S)
    return m.group(1).strip() if m else ""


def def_meta(chapter):
    leaf = chapter[7:]  # strip "Chapter"
    ns = f"BookProof.{leaf}"
    path = f"{WS}/Definitions/Def_{chapter}.lean"
    doc = module_docstring(path)
    title = CHAPTER[chapter]["title"]
    tags = dedupe(["timepiece"] + CHAPTER[chapter]["tags"])
    # clean NL: drop the book-chapter heading lines, unwrap prose paragraphs,
    # and open with a concrete lead-in so it never reads like a book title stub.
    paras = [re.sub(r"\s+", " ", p).strip() for p in doc.split("\n\n")]
    paras = [p for p in paras if p and not p.startswith("#")]
    lead = (f"Formal definitions for the {title} of the timepiece Lean 4 "
            f"formalization (module `BookProof.{leaf}`, source chapter "
            f"`BookProof/Chapter{leaf}.lean`).")
    nl = lead + ("\n\n" + "\n\n".join(paras) if paras else "")
    if len(nl) > 4000:
        nl = nl[:4000].rstrip() + "\n\n..."
    return {
        "definition_name": chapter,
        "namespace": ns,
        "file": path,
        "title": title,
        "nl": nl,
        "source": f"{REPO}/BookProof/Chapter{leaf}.lean",
        "tags": tags,
    }


def node_tags(slug):
    tags = ["timepiece"]
    for prefix, extra in NODE_EXTRA.items():
        if slug.startswith(prefix):
            tags += extra
            break
    return tags


def main():
    manifest = json.load(open(f"{WS}/state/wave_manifest.json"))
    meta = json.load(open(f"{WS}/state/wave_meta.json"))
    chapters = sorted({n["leaf"] for n in manifest})

    defs = {c: def_meta(c) for c in chapters}

    thms = {}
    for n in manifest:
        slug, name, leaf = n["slug"], n["name"], n["leaf"]
        m = meta[slug]
        require_gate(m["source"], m)
        tags = list(m.get("tags") or node_tags(slug))
        if "timepiece" not in tags:
            tags = ["timepiece"] + tags
        thms[slug] = {
            "name": name,
            "chapter": leaf,
            "file": f"{WS}/Theorems/Thm_{slug}.lean",
            "title": m["title"],
            "nl": m.get("nl") or m["title"],
            "source": m["source"],
            "tags": tags,
        }

    # topological order of solutions: importer after imported
    sol_files = sorted(glob.glob(f"{WS}/Solutions/Sol_BookProof_*.lean"))
    alln = {os.path.basename(p)[len("Sol_"):-len(".lean")] for p in sol_files}
    adj = collections.defaultdict(set)
    indeg = collections.defaultdict(int)
    for p in sol_files:
        slug = os.path.basename(p)[len("Sol_"):-len(".lean")]
        for dep in re.findall(r"import Theorems\.Thm_(\S+)", open(p, encoding="utf-8").read()):
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

    # validate: every importer appears strictly after all of its imports
    pos = {s: i for i, s in enumerate(order)}
    for p in sol_files:
        slug = os.path.basename(p)[len("Sol_"):-len(".lean")]
        for dep in re.findall(r"import Theorems\.Thm_(\S+)", open(p, encoding="utf-8").read()):
            assert pos[dep] < pos[slug], f"{slug} precedes its dependency {dep}"

    # hard guard: any source folder is fine EXCEPT Book/ (the prose book
    # chapters — titles without formal math). Sources must point at the
    # timepiece repo. Note: '/Book/' cannot match '/BookProof/' ('P' != '/').
    # Targets from PnpProof/UsedRoute/UnusedRoute additionally require the
    # Phase-0 gate flags (see require_gate above).
    for c, d in defs.items():
        assert "/Book/" not in d["source"], c
        assert d["source"].startswith(REPO), c
        require_gate(d["source"], d)
    for s, t in thms.items():
        assert "/Book/" not in t["source"], s
        assert t["source"].startswith(REPO), s

    out = {"defs": defs, "thms": thms, "sol_order": order}
    os.makedirs(f"{WS}/pipeline", exist_ok=True)
    with open(f"{WS}/pipeline/wave_upload.json", "w") as f:
        json.dump(out, f, indent=1)
    print(f"defs: {len(defs)}  thms: {len(thms)}  sol_order: {len(order)}")
    for c in chapters:
        print(f"  def {c}: nl {len(defs[c]['nl'])} chars, tags {defs[c]['tags']}")
    print("first sol order:", order[:6])


if __name__ == "__main__":
    main()
