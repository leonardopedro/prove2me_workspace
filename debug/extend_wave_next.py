#!/usr/bin/env python3
"""Extend pipeline/wave_upload.json with the next batch of timepiece theorems.

Batch chapters (2026-09-10):
  * thm/sol-only (defs already in the current wave):
      ContinuityUnitaryInfinite, H1, H4, H6, H8, H9, SirkSpectralGeometry
  * def + thm/sol (new def bundles, platform-safe import closure):
      SirkRestart, SirkRitzSpectrum, SirkTruncation

Rules:
  * Def entries use the same schema as extend_wave.py (def_meta).
  * Thm entries are added for every Thm_BookProof_Chapter<X>_*.lean file that
    COMPILES locally (skips e.g. the two ContinuityUnitaryInfinite stubs whose
    lemmas were embedded into the def bundle and now duplicate them).
  * Every added thm slug is appended to sol_order in topological order (a sol's
    `import Theorems.Thm_...` deps come first), so the uploader publishes the
    thm stubs before attempting their solutions.  Sol files that do not compile
    locally still get their slug in sol_order: the thm publishes as Open and the
    sol item fails gracefully (the established pattern for cross-chapter node
    dependencies).
  * Append-only: never removes existing entries.
"""
import collections
import glob
import json
import os
import re
import subprocess

WS = "/home/leo/prove2me_workspace"
REPO = "https://github.com/leonardopedrio/timepiece/blob/61595bc"
PIPE = f"{WS}/pipeline/wave_upload.json"
ELAN = "/home/leo/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake"

# New def bundles for this batch (platform-safe: their `import Definitions.` deps
# are already published or in the current wave).
NEW_DEFS = ["ChapterSirkRestart", "ChapterSirkRitzSpectrum", "ChapterSirkTruncation",
            "ChapterSirkGramWhitening", "ChapterSirkGramCutoff", "ChapterSirkTrotterKato",
            "ChapterSirkMultiShift",
            "ChapterSirkTrotterKatoGalerkin", "ChapterSirkGapTable", "ChapterSirkCertifiedGap",
            "ChapterSirkRitzMinMax", "ChapterSirkRitzPerturbation", "ChapterNavierStokesSignedShift",
            "ChapterNavierStokesHermiteCanonical", "ChapterSirkCertificateReader",
            "ChapterSirkBandLedger", "ChapterFockSecondQuantization", "ChapterFockOneParticleGap",
            "ChapterBandEnclosure", "ChapterFriedrichsFormGap",
            "ChapterNavierStokesFarisLavineLift", "ChapterNavierStokesDiffFarisLavine",
            "ChapterNavierStokesSecondQuant", "ChapterQgHermiteCore",
            "ChapterRitzCertificate", "ChapterNavierStokesLagrangianCanonical"]
# Chapters whose thm/sol stubs are added (thm-only ones rely on current-wave defs).
THM_CHAPS = ["ChapterContinuityUnitaryInfinite", "ChapterH1", "ChapterH4",
             "ChapterH6", "ChapterH8", "ChapterH9", "ChapterSirkSpectralGeometry",
             "ChapterSirkRestart", "ChapterSirkRitzSpectrum", "ChapterSirkTruncation",
             "ChapterSirkGramWhitening", "ChapterSirkGramCutoff", "ChapterSirkTrotterKato",
             "ChapterSirkMultiShift"]
# Chapters whose thm/sol slugs come from the wave manifest (the generator named
# their files after the source namespaces, e.g. BookProof_RitzMinMax_*, so the
# Chapter-prefixed glob does not apply).
MANIFEST_CHAPS = ["ChapterSirkTrotterKatoGalerkin", "ChapterSirkGapTable",
                  "ChapterSirkCertifiedGap", "ChapterSirkRitzMinMax",
                  "ChapterSirkRitzPerturbation", "ChapterNavierStokesSignedShift"]
# Chapters whose thm files are found by a namespace-prefix glob (the generator
# names them after the source namespaces; used for wave-4 Fock/Band/Sirk/NS batch).
GLOB_PREFIXES = [
    ("ChapterNavierStokesHermiteCanonical", "NavierStokesFlow_HermiteCanonical_"),
    ("ChapterSirkCertificateReader", "SirkCertificateReader_"),
    ("ChapterSirkBandLedger", "SirkBandLedger_"),
    ("ChapterFockSecondQuantization", "FockSecondQuantization_"),
    ("ChapterFockOneParticleGap", "FockOneParticleGap_"),
    ("ChapterBandEnclosure", "BandEnclosure_"),
    ("ChapterFriedrichsFormGap", "FriedrichsFormGap_"),
    ("ChapterNavierStokesFarisLavineLift", "NavierStokesFlow_FarisLavineLift_"),
    ("ChapterNavierStokesDiffFarisLavine", "NavierStokesFlow_DiffFarisLavine_"),
    ("ChapterNavierStokesSecondQuant", "NavierStokesFlow_SecondQuant_"),
    ("ChapterQgHermiteCore", "QgHermiteCore_"),
    ("ChapterRitzCertificate", "RitzCertificate_"),
    ("ChapterNavierStokesLagrangianCanonical", "NavierStokesFlow_LagrangianCanonical_"),
]

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


def compiles(path):
    r = subprocess.run([ELAN, "env", "lean", path], capture_output=True, text=True)
    return r.returncode == 0


def main():
    wave = json.load(open(PIPE, encoding="utf-8"))
    for chap in NEW_DEFS:
        if chap not in wave["defs"]:
            wave["defs"][chap] = def_meta(chap)

    # Valid thm stubs: compile locally.
    new_slugs = []
    for chap in THM_CHAPS:
        for f in sorted(glob.glob(f"{WS}/Theorems/Thm_BookProof_Chapter{chap[7:]}_*.lean")):
            slug = os.path.basename(f)[len("Thm_"):-len(".lean")]
            if slug in wave["thms"]:
                new_slugs.append(slug)
                continue
            if not compiles(f):
                print(f"skip thm (no compile): {slug}")
                continue
            new_slugs.append(slug)
            wave["thms"][slug] = thm_meta(slug)

    # Manifest-based chapters: slugs from state/wave_manifest.json.
    manifest = json.load(open(f"{WS}/state/wave_manifest.json", encoding="utf-8"))
    for n in manifest:
        if n["leaf"] not in MANIFEST_CHAPS:
            continue
        slug = n["slug"]
        f = f"{WS}/Theorems/Thm_{slug}.lean"
        if slug in wave["thms"]:
            new_slugs.append(slug)
            continue
        if not compiles(f):
            print(f"skip thm (no compile): {slug}")
            continue
        new_slugs.append(slug)
        wave["thms"][slug] = thm_meta(slug)

    # Namespace-prefix glob chapters (wave-4 Fock/Band/Sirk/NS batch).
    for _chap, prefix in GLOB_PREFIXES:
        for f in sorted(glob.glob(f"{WS}/Theorems/Thm_BookProof_*{prefix}*.lean")):
            slug = os.path.basename(f)[len("Thm_"):-len(".lean")]
            if slug in wave["thms"]:
                new_slugs.append(slug)
                continue
            if not compiles(f):
                print(f"skip thm (no compile): {slug}")
                continue
            new_slugs.append(slug)
            wave["thms"][slug] = thm_meta(slug)

    # Topological order: a sol slug comes after every thm it imports.
    alln = set(new_slugs)
    adj = collections.defaultdict(set)
    indeg = collections.defaultdict(int)
    for slug in new_slugs:
        p = f"{WS}/Solutions/Sol_{slug}.lean"
        if not os.path.exists(p):
            continue
        for dep in re.findall(r"import Theorems\.Thm_(\S+)", open(p, encoding="utf-8").read()):
            if dep in alln and dep != slug:
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
    cyc = sorted(alln - set(order))
    # Cycles happen when sols import each other's thm stubs (mutually recursive
    # source proofs).  The uploader publishes ALL thm: items before ANY sol:, so
    # the relative order inside a cycle is irrelevant -- just append them.
    if cyc:
        print(f"warning: {len(cyc)} slugs in import cycles, appending in sorted order")
        order += cyc

    pre = [s for s in wave["sol_order"] if s not in set(order)]
    wave["sol_order"] = pre
    for slug in order:
        wave["sol_order"].append(slug)

    with open(PIPE, "w", encoding="utf-8") as f:
        json.dump(wave, f, indent=1)
    print(f"defs: {len(wave['defs'])}  thms: {len(wave['thms'])}  "
          f"sol_order: {len(wave['sol_order'])}  (+{len(order)} new slugs)")


if __name__ == "__main__":
    main()