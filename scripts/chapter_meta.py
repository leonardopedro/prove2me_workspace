#!/usr/bin/env python3
"""Auto-generated chapter metadata for the full BookProof payload.

Derives per-chapter titles and tags from (a) the priority-tier assignment in
state/chapter_tiers.json and (b) keyword patterns in the chapter name, with a
hand-curated title override for the 7 already-published chapters (kept in sync
with the old wave_upload_spec CHAPTER dict).

Used by wave_metadata.py and wave_upload_spec.py so the whole 601-chapter
payload gets consistent, human-readable tags without hand-writing each one.
"""
import json
import os
import re

WS = "/home/leo/prove2me_workspace"
PROJ = "/home/leo/Projects/timepiece"
TIERS = json.load(open(f"{WS}/state/chapter_tiers.json"))

TIER_TAGS = {
    "t1_qym_esa": ["timepiece", "qym", "esa", "gauge-theory"],
    "t2_sirk": ["timepiece", "sirk", "spectral-theory", "numerical-analysis"],
    "t3_navierstokes": ["timepiece", "navier-stokes", "esa", "pde"],
    "t4_rest": ["timepiece"],
}

# keyword -> (title fragment, extra tags) for the "rest" tier and to refine
# tier-1/2/3 chapters where the chapter name is more specific than the tier.
KW = [
    (["Fock"], "Fock-space", ["fock-space"]),
    (["Hermite"], "Hermite basis", ["hermite", "basis"]),
    (["Esa"], "essential self-adjointness (ESA)", ["esa"]),
    (["Sirk"], "SIRK certified", ["sirk"]),
    (["Friedrichs"], "Friedrichs extension", ["friedrichs", "extension-theory"]),
    (["FarisLavine"], "Faris–Lavine", ["faris-lavine"]),
    (["QuantumGravity"], "Quantum gravity", ["quantum-gravity"]),
    (["YangMills"], "Yang–Mills", ["yang-mills"]),
    (["NavierStokes"], "Navier–Stokes", ["navier-stokes"]),
    (["Carleman"], "Carleman linearization", ["carleman"]),
    (["Spectral"], "Spectral theory", ["spectral-theory"]),
    (["Stone"], "Stone / one-parameter groups", ["stone", "one-parameter-semigroups"]),
    (["VonNeumann"], "von Neumann algebras", ["von-neumann", "operator-algebras"]),
    (["Abelian"], "Abelian von Neumann", ["abelian", "operator-algebras"]),
    (["Attention"], "Attention", ["attention", "ml"]),
    (["Softmax"], "Softmax", ["softmax", "ml"]),
    (["Bayes"], "Bayesian inference", ["bayes", "probability"]),
    (["Born"], "Born rule", ["born", "quantum-foundations"]),
    (["Gleason"], "Gleason", ["gleason", "quantum-foundations"]),
    (["Coherent"], "Coherent states", ["coherent-states"]),
    (["Majorana"], "Majorana", ["majorana", "fermions"]),
    (["Lorentz"], "Lorentz group", ["lorentz", "relativity"]),
    (["Gravity"], "Gravity", ["gravity"]),
    (["Brst"], "BRST", ["brst", "gauge-theory"]),
    (["BRST"], "BRST", ["brst", "gauge-theory"]),
    (["Qg"], "QG gauge", ["qym", "quantum-gravity"]),
    (["QG"], "QG gauge", ["qym", "quantum-gravity"]),
    (["Ritz"], "Ritz / min-max", ["ritz", "spectral-theory"]),
    (["Resolvent"], "Resolvent", ["resolvent", "spectral-theory"]),
    (["Unbounded"], "Unbounded operators", ["unbounded-operators"]),
    (["Kato"], "Kato / perturbation", ["kato", "perturbation-theory"]),
    (["MassGap"], "Mass gap", ["mass-gap"]),
    (["GaugeFixing"], "Gauge fixing", ["gauge-fixing"]),
    (["Ghost"], "Ghost fields", ["ghosts", "brst"]),
    (["Parity"], "Parity", ["parity", "particle-physics"]),
    (["CPT"], "CPT", ["cpt", "particle-physics"]),
    (["SqSum"], "Square-summable", ["square-summable"]),
    (["ShiftedQuadratic"], "Shifted quadratic", ["shifted-quadratic"]),
    (["Quadratic"], "Quadratic form", ["quadratic-form"]),
    (["Nonneg"], "Nonnegative operators", ["nonnegative-operators"]),
    (["Schur"], "Schur / Gershgorin", ["schur", "matrix-theory"]),
    (["Gauss"], "Gauss / quadrature", ["gauss", "quadrature"]),
    (["Mehler"], "Mehler kernel", ["mehler", "gaussian"]),
    (["Hashimoto"], "Hashimoto shift", ["hashimoto", "shift-operator"]),
    (["Diffuse"], "Diffuse model", ["diffuse", "probability"]),
    (["DutchBook"], "Dutch book", ["dutch-book", "probability"]),
    (["Measure"], "Measure theory", ["measure-theory"]),
    (["Probability"], "Probability", ["probability"]),
    (["Entropy"], "Entropy", ["entropy"]),
    (["MaxEntropy"], "Maximum entropy", ["max-entropy"]),
    (["Markov"], "Markov", ["markov"]),
    (["LayerNorm"], "Layer normalization", ["layernorm", "ml"]),
    (["Solovay"], "Solovay", ["solovay", "functional-analysis"]),
    (["Truncation"], "Truncation", ["truncation"]),
    (["WallEsa"], "Wall ESA", ["esa", "wall"]),
    (["BddBelow"], "Bounded below", ["bounded-below"]),
    (["Ell2"], "ℓ² separability", ["l2", "separable"]),
    (["Lp"], "Lp spaces", ["lp-spaces"]),
    (["FreeField"], "Free field", ["free-field", "qft"]),
    (["Vielbein"], "Vielbein", ["vielbein", "gravity"]),
    (["Scalaron"], "Scalaron", ["scalaron", "gravity"]),
    (["Starobinsky"], "Starobinsky", ["starobinsky", "gravity"]),
    (["GelMann"], "Gell-Mann", ["gell-mann", "su3"]),
]


def tier_of(leaf):
    base = leaf if leaf.endswith(".lean") else f"{leaf}.lean"
    for tier, lst in TIERS.items():
        if base in lst:
            return tier
    return "t4_rest"


def tags_for(leaf):
    """timepiece + tier tags + keyword tags (deduped, order-preserving)."""
    tier = tier_of(leaf)
    tags = list(TIER_TAGS[tier])
    for kws, _frag, extra in KW:
        if any(k in leaf for k in kws):
            for t in extra:
                if t not in tags:
                    tags.append(t)
    if "timepiece" not in tags:
        tags = ["timepiece"] + tags
    return tags


def title_for(leaf):
    """Human title: keyword fragment or readable chapter name."""
    base = leaf[:-5] if leaf.endswith(".lean") else leaf
    for kws, frag, _extra in KW:
        if any(k in base for k in kws):
            return frag
    name = base[len("Chapter"):]
    # insert spaces at camelCase boundaries, keep abbreviations intact
    pretty = re.sub(r"(?<=[a-z0-9])(?=[A-Z])", " ", name)
    return pretty


if __name__ == "__main__":
    # quick self-check: show a sample across tiers
    for tier, lst in TIERS.items():
        for leaf in sorted(lst)[:3]:
            print(f"{tier:14s} {leaf:45s} {title_for(leaf)}")
            print(f"    tags: {tags_for(leaf)}")