#!/usr/bin/env python3
"""Phase 6 metadata for the wave nodes: per-node title / natural-language
statement / tags / source, derived from the chapter docstrings (the sketch
facts carry the exact docstring source range) with hand-written entries for
the few nodes that lack one.  Output: state/wave_meta.json keyed by slug.

The natural-language text keeps the source prose (it is already written as
academic descriptions next to the formal statement) but strips Lean doc-markers
and backticks so it renders as plain Markdown + KaTeX.  A short Formalization
Note naming the Lean identifier and source line is appended to every entry.
"""
import json
import re
import sys

WS = "/home/leo/prove2me_workspace"
PROJ = "/home/leo/Projects/timepiece"
SHA = "61595bc"  # source commit for blob links

# leaf -> human tags describing the chapter's math domain
LEAF_TAGS = {
    "ChapterMassGap": ["timepiece", "qym", "mass-gap", "operator-algebras"],
    "ChapterBRSTNilpotent": ["timepiece", "qym", "brst", "ghosts"],
    "ChapterGhostField": ["timepiece", "qym", "brst", "ghosts"],
    "ChapterNavierStokes": ["timepiece", "navier-stokes", "ghosts"],
    "ChapterYangMillsFieldStrength": ["timepiece", "qym", "yang-mills", "gauge-theory"],
    "ChapterSirkFinitePrecision": ["timepiece", "sirk", "certified-gap", "spectral-theory"],
    "ChapterGaugeFixing": ["timepiece", "qym", "gauge-fixing", "brst"],
    "ChapterBaryonAsymmetry": ["timepiece", "qym", "baryon-asymmetry", "particle-physics"],
    "ChapterMajoranaClifford": ["timepiece", "qym", "majorana", "clifford-algebra"],
    "ChapterMajoranaProp61": ["timepiece", "qym", "majorana", "particle-physics"],
    "ChapterMajoranaProp76": ["timepiece", "qym", "majorana", "particle-physics"],
    "ChapterParityMajoranaQuant": ["timepiece", "qym", "parity", "majorana", "quantization"],
    "ChapterYangMillsBianchi": ["timepiece", "qym", "yang-mills", "bianchi-identity"],
    "ChapterYangMillsSU3": ["timepiece", "qym", "su3", "structure-constants"],
    "ChapterSirkGroupTransfer": ["timepiece", "sirk", "one-parameter-groups", "transfer"],
}

# Hand-written statements for nodes without a docstring.  Keys are slugs.
HAND = {
    "BookProof_MassGap_shiftedSpectrum_vacuum": (
        "Vacuum energy is unchanged by the number-operator shift.\n\n"
        "Let $E$ be an energy assignment on the $(n+2)$-level spectrum and $\\lambda$ the "
        "shift amount. The shifted spectrum is $E_i + \\lambda \\cdot n_i$, where $n_i$ is "
        "the eigenvalue of the number operator at level $i$. At the vacuum level $i = 0$ "
        "the number-operator eigenvalue is $0$, so\n$$\n\\text{shiftedSpectrum}(E,\\lambda,0)=E_0.\n$$\n\n"
        "This is the 'no observable consequence' half of the mass-gap argument: adding the "
        "number operator to the Hamiltonian leaves the vacuum energy untouched."
    ),
    "BookProof_MassGap_shiftedSpectrum_excited": (
        "Every excited energy is shifted by exactly $\\lambda$.\n\n"
        "For a non-vacuum level $i \\neq 0$ the number operator has eigenvalue $1$, so the "
        "shifted spectrum is\n$$\n\\text{shiftedSpectrum}(E,\\lambda,i)=E_i+\\lambda.\n$$\n\n"
        "Together with `shiftedSpectrum_vacuum` this gives the complete spectrum of the "
        "number-operator-shifted Hamiltonian: a rigid shift of the excited states by $\\lambda$."
    ),
    "BookProof_MassGap_massGap_shifted_gapless": (
        "Headline (arbitrary mass gap): for the gapless free field the number-operator "
        "shift produces a mass gap equal to $\\lambda$.\n\n"
        "Take the free (gapless) field $E \\equiv 0$ on the $(n+2)$-level spectrum and "
        "shift by the number operator scaled by $\\lambda$. The mass gap — the least "
        "excited-state energy — becomes exactly\n$$\n\\text{massGap}(\\text{shiftedSpectrum}(0,\\lambda))=\\lambda.\n$$\n\n"
        "Since $\\lambda$ is arbitrary, the mass gap can be set to any prescribed value "
        "without changing the observables (the vacuum is untouched), which is the "
        "formal core of the mass-gap argument in the book."
    ),
    "BookProof_BRSTNilpotent_beta_move": (
        "Normal ordering of a single annihilation operator.\n\n"
        "Let $\\chi_a,\\beta_a$ be ghost creation and annihilation operators satisfying the "
        "canonical anticommutation relations in a ring $R$ over $\\mathbb R$. Pushing the "
        "annihilation operator $\\beta_e$ past a pair of creation operators $\\chi_d \\chi_g$ "
        "produces two contraction terms plus a normal-ordered remainder:\n$$\n"
        "\\beta_e\\,(\\chi_d\\chi_g) = (e=d\\;?\\;\\chi_g : 0) - (e=g\\;?\\;\\chi_d : 0) + \\chi_d\\chi_g\\,\\beta_e.\n$$\n\n"
        "This is the fundamental rearrangement used to normal-order powers of the BRST "
        "charge and is applied throughout the nilpotency proof."
    ),
    "BookProof_BRSTNilpotent_chi_swap4": (
        "Four creation operators can be reordered in pairs with sign $+1$.\n\n"
        "For ghost creation operators satisfying the canonical anticommutation "
        "relations,\n$$\n\\chi_a\\chi_b\\chi_c\\chi_d = \\chi_c\\chi_d\\chi_a\\chi_b.\n$$\n\n"
        "Moving one anticommuting pair past another is an even permutation of the four "
        "fermionic operators, so no sign is introduced."
    ),
    "BookProof_BRSTNilpotent_chi_cyc3": (
        "Cyclic rotation of three creation operators has sign $+1$.\n\n"
        "For ghost creation operators with canonical anticommutation relations,\n$$\n"
        "\\chi_a\\chi_b\\chi_c = \\chi_b\\chi_c\\chi_a.\n$$\n\n"
        "A cyclic permutation of three anticommuting elements is an even permutation."
    ),
    "BookProof_BRSTNilpotent_quartic_term_zero": (
        "The purely quartic ghost term vanishes.\n\n"
        "Let $f_{abe}$ be structure constants, $\\chi$ the ghost creation operators and "
        "$\\beta$ the ghost annihilation operators satisfying canonical anticommutation "
        "relations. The fully normal-ordered piece of $Q^2$,\n$$\n"
        "\\sum_{a,b,e,d,g,h} f_{abe}\\,f_{dgh}\\,(\\chi_a\\chi_b\\chi_d\\chi_g\\,\\beta_e\\beta_h)=0,\n$$\n\n"
        "vanishes: it is antisymmetric under exchanging the two $Q$-factors (even sign on "
        "the four $\\chi$'s, odd sign on the two $\\beta$'s), hence equals its own negative."
    ),
    "BookProof_BRSTNilpotent_contracted_terms_zero": (
        "The contracted (two-contraction) terms of $Q^2$ vanish by the Jacobi identity.\n\n"
        "Let $f_{abe}$ be structure constants satisfying the Jacobi identity and "
        "$\\chi,\\beta$ canonical anticommuting ghost operators. The sum of the terms in "
        "$Q^2$ that arise from contracting two pairs of ghosts,\n$$\n"
        "\\sum_{a,b,c,e,d} f_{abe}\\,f_{cd}\\,(\\cdots)=0,\n$$\n\n"
        "vanishes precisely because $f$ satisfies the Jacobi identity. Together with "
        "`quartic_term_zero` this leaves only the cubic (one-contraction) remainder, "
        "which is handled separately in the nilpotency proof."
    ),
    "BookProof_BRSTNilpotent_brst_charge_nilpotent": (
        "The BRST charge is nilpotent.\n\n"
        "Let $f_{abe}$ be structure constants satisfying the Jacobi identity and "
        "$\\chi,\\beta$ ghost creation/annihilation operators with canonical "
        "anticommutation relations. The cubic BRST charge\n$$\n"
        "Q=\\sum_{a,b,e} f_{abe}\\,\\chi_a\\chi_b\\,\\beta_e\n$$\n"
        "squares to zero: $Q^2=0$. The quartic term vanishes by antisymmetry, the "
        "contracted terms vanish by the Jacobi identity, and the surviving cubic "
        "remainder cancels against the corresponding one-contraction term."
    ),
    "BookProof_SirkFinitePrecision_CertInterval_mem_add": (
        "Interval addition is sound for membership.\n\n"
        "If $x$ lies in the interval $I$ and $y$ lies in the interval $J$, then their sum "
        "lies in the interval sum: $I.\\text{add}(J) \\ni (x+y)$, i.e.\n$$\n"
        "I\\ni x \\;\\wedge\\; J\\ni y \\;\\Longrightarrow\\; (I+J)\\ni(x+y).\n$$\n\n"
        "This is the directed-rounding soundness certificate for interval addition used "
        "by the certified-evaluation layer."
    ),
    "BookProof_SirkFinitePrecision_CertInterval_mem_neg": (
        "Interval negation is sound for membership.\n\n"
        "If $x$ lies in the interval $I$ then $-x$ lies in the negated interval:\n$$\n"
        "I\\ni x \\;\\Longrightarrow\\; (-I)\\ni(-x).\n$$\n"
    ),
    "BookProof_SirkFinitePrecision_CertInterval_mem_sub": (
        "Interval subtraction is sound for membership.\n\n"
        "If $x$ lies in $I$ and $y$ lies in $J$ then $x-y$ lies in the interval "
        "difference: $I.\\text{sub}(J) \\ni (x-y)$."
    ),
    "BookProof_SirkFinitePrecision_CertInterval_mem_mul": (
        "Interval multiplication is sound for membership.\n\n"
        "If $x$ lies in $I$ and $y$ lies in $J$ then their product lies in the interval "
        "product: $I.\\text{mul}(J) \\ni (x\\,y)$. The product interval is built from all "
        "four endpoint products, so the soundness proof checks each pairing."
    ),
    "BookProof_SirkFinitePrecision_CertInterval_mem_widen": (
        "Widening an interval preserves membership.\n\n"
        "If $x$ lies in $I$ then $x$ also lies in every widening of $I$ (an outward "
        "expansion used to model directed/outward rounding): $I\\ni x \\Longrightarrow "
        "\\text{widen}(I)\\ni x$."
    ),
    "BookProof_GaugeFixing_addDeg_fst": (
        "First component of the bidegree addition.\n\n"
        "For bidegrees $a,b$ the degree addition satisfies\n$$\n"
        "\\text{addDeg}(a,b)_1 = a_1 + b_1.\n$$\n\n"
        "This is the first projection of the componentwise addition on the bidegree "
        "monoid used to grade the gauge-fixing BRST complex."
    ),
    "BookProof_GaugeFixing_addDeg_snd": (
        "Second component of the bidegree addition.\n\n"
        "For bidegrees $a,b$ the degree addition satisfies\n$$\n"
        "\\text{addDeg}(a,b)_2 = a_2 + b_2.\n$$\n\n"
        "This is the second projection of the componentwise addition on the bidegree "
        "monoid used to grade the gauge-fixing BRST complex."
    ),
    "BookProof_GaugeFixing_Pm_mul_Vm": (
        "Action of the gauge-fixing projection on the vacuum.\n\n"
        "In the $2\\times2$ matrix model the projection matrix $P_m$ annihilates onto the "
        "vacuum while $V_m$ creates it; they satisfy\n$$\nP_m\\,V_m = P_m.\n$$\n"
    ),
    "BookProof_GaugeFixing_Qm_ne_zero": (
        "The BRST charge matrix is nonzero.\n\n"
        "In the $2\\times2$ matrix model the BRST charge matrix $Q_m$ is not the zero "
        "matrix, so the model's BRST differential is non-trivial."
    ),
    "BookProof_GaugeFixing_Pm_ne_zero": (
        "The gauge-fixing projection is nonzero.\n\n"
        "In the $2\\times2$ matrix model the projection $P_m$ is not the zero matrix."
    ),
    "BookProof_GaugeFixing_matrixModel_s_Psi_ne_zero": (
        "The model gauge-fixing BRST differential of $\\Psi$ is nonzero.\n\n"
        "In the concrete matrix model the gauge-fixing Lagrangian evaluates to the "
        "identity matrix, $s\\Psi = 1$, which in particular is nonzero — so the "
        "evaluation identity has non-trivial content."
    ),
}


def clean_doc(doc):
    """Turn a raw /-- … -/ docstring into plain Markdown prose."""
    text = re.sub(r"^/--\s*", "", doc, flags=re.S)
    text = re.sub(r"\s*-/$", "", text, flags=re.S)
    text = re.sub(r"\*\*(.+?)\*\*", r"**\1**", text)  # keep bold
    # Lean backticks -> inline code markers (they render readably)
    text = re.sub(r"`([^`]+)`", r"`\1`", text)
    return text.strip()


def doc_lines(leaf, slug):
    """Find the source line span of the node's declaration (for the source link)."""
    with open(f"{WS}/state/sketch/sketch_{leaf}.jsonl") as f:
        for line in f:
            r = json.loads(line)
            if r["kind"] == "decl" and r.get("nameText") == slug.split(".")[-1]:
                return r["declStart"]["line"], r["declEnd"]["line"]
    return 0, 0


def first_sentence(prose, fallback):
    """First sentence of the prose, taken across line breaks, as a short title."""
    joined = re.sub(r"\s+", " ", prose).strip()
    m = re.search(r"^(.+?[.])(?:\s|$)", joined)
    sent = (m.group(1) if m else joined)[:190].rstrip(".").strip()
    sent = re.sub(r"^\*\*|\*\*$", "", sent).strip()
    if not sent or len(sent) < 10:
        sent = fallback
    return sent


def main():
    man = json.load(open(f"{WS}/state/wave_manifest.json"))
    meta = json.load(open(f"{WS}/state/wave_docstrings.json"))
    out = {}
    for m in man:
        slug = m["slug"]
        name = m["name"]
        leaf = m["leaf"]
        short = name.split(".")[-1]
        tags = LEAF_TAGS[leaf]
        s, e = doc_lines(leaf, name)
        src = (f"https://github.com/leonardopedro/timepiece/blob/{SHA}/"
               f"BookProof/{leaf}.lean#L{s}-L{e}")
        doc = meta.get(slug)
        if doc:
            prose = clean_doc(doc)
        elif slug in HAND:
            prose = HAND[slug]
        else:
            prose = f"The Lean 4 theorem `{short}` in the `{leaf}` chapter of the timepiece formalization."
        title = first_sentence(prose, short)
        # A proper natural_language_statement: prose + formalization note
        nl = prose + ("\n\n" if not prose.endswith("\n\n") else "") + (
            f"\n\n**Formalization Note.** Lean 4 identifier: `{name}` "
            f"(module `BookProof.{leaf.removeprefix('Chapter')}`), line-linked source: "
            f"`{leaf}.lean` lines {s}–{e}."
        )
        out[slug] = {
            "leaf": leaf,
            "name": name,
            "short": short,
            "tags": tags,
            "source": src,
            "title": title,
            "nl": nl,
        }
    with open(f"{WS}/state/wave_meta.json", "w", encoding="utf-8") as f:
        json.dump(out, f, indent=1, ensure_ascii=False)
    n = len(out)
    print(f"wrote metadata for {n} nodes")
    miss = [s for s, v in out.items() if len(v["nl"]) < 60]
    if miss:
        print("SUSPICIOUSLY SHORT NL:", miss)


if __name__ == "__main__":
    main()
