#!/usr/bin/env python3
"""Freeze the prove2me reuse search into a self-contained markdown report.

The audience is the **offline** LLM-Lean4-specialist working in `../timepiece`
(Lean v4.28.0, only Mathlib, no network).  Because that specialist cannot query
prove2me, this script fetches the *verbatim* `formal_statement` of every reusable
theorem (as stored on the platform, Lean 4.33.1) and writes it, with the route
mapping and a portability verdict, to a report inside `../timepiece`.

Read-only against the platform.

Usage:
    python3 debug/export_reusable_report.py [--out ../timepiece/PROVE2ME_REUSABLE_THEOREMS.md]
"""
import argparse
import datetime
import json
import os
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

INDEX = os.path.join(WS, "state", "platform_index.jsonl")

# name -> (route item, what it buys, portability)
M = "Mathlib-only — can be restated directly on the 4.28 API."
D = "Needs platform-local definitions (re-declare a minimal abstraction and state the result over it)."

CATALOG = {
    # --- item 1: Plancherel / spatial Fourier unitary -----------------------
    "BookProof.ChapterMajoranaProp76.fourierTransform_isNote4Unitary": (
        "1", "The L² Fourier transform is a unitary (`IsNote4Unitary`) — the Plancherel "
        "counterpart of the spatial transform. Ours already, but it is the *shape* to "
        "mirror on `L²(ℝ_p^d × ℝ_u^m)`.", D),
    "FourierFA.parseval": (
        "1/3", "Parseval/Plancherel for the finite abelian group DFT (the discrete-mode "
        "picture of the spatial transform).", D),
    "FourierFA.parseval_norm": (
        "1/3", "Norm form of the same Parseval identity.", D),
    "FourierFA.dft_conv": (
        "3", "The DFT turns convolution into pointwise product — the discrete shadow of "
        "‘local products become momentum convolutions’.", D),
    "ChebotarevDFT.dft_conv": (
        "3", "Same convolution theorem, independent formalization (cross-check).", D),
    # --- items 1–3: form domain, cutoff -------------------------------------
    "QFS.formHs_ball_ne_top_of_L2inclusion": (
        "1–3", "The `H^s` form-domain ball has finite measure once `L²` is included — the "
        "formal content of the finite energy/momentum cutoff (residual (iii)).", D),
    "QFS.formHs_congr_ae": (
        "1–3", "The `H^s` form is a.e.-invariant (well-definedness of the form domain).", D),
    "QFS.localPoincare_visible_on": (
        "1–3", "A local Poincaré inequality for the form — the coercivity input that makes "
        "the cutoff comparison bounded below.", D),
    "QFS.chain_estimate": (
        "1–3", "Chaining estimate gluing local Poincaré bounds — the `H^s` embedding "
        "argument behind the Faris–Lavine domain.", D),
    "QFS.cutoff_le_one": (
        "1–3", "The cutoff is ≤ 1 (the sharp bound needed to keep `c` uniform).", D),
    "QFS.lintegral_stepG_eq": (
        "1–3", "Layer-cake/step-function identity used to bound the form.", D),
    "QFS.limsup_lintegral_stepG_le": (
        "1–3", "The limsup form of the same bound (cutoff removal).", D),
    "QFS.path_props_long": (
        "1–3", "Path properties of the chaining argument (supporting lemma).", D),
    # --- item 3: convolution operator ---------------------------------------
    "MeasureTheory.L2.convolutionCLM_isSymmetric_of_conj_neg": (
        "3", "The convolution operator is symmetric when the kernel satisfies "
        "`f (-x) = conj (f x)` — symmetry/self-adjointness of `Û_i(q)`.", M),
    "MeasureTheory.L2.exists_convolutionCLM_isCompactOperator_of_compactSpace": (
        "3", "Convolution with a continuous kernel on a compact group is compact — "
        "compactness of the convolution mode operator.", M),
    # --- item 4: N + 1 onto, coercivity -------------------------------------
    "VectorSpaceOpt.coercive_selfadjoint_bijective": (
        "4", "A coercive real self-adjoint bounded operator is bijective — the "
        "bounded-cutoff surrogate for hypothesis (3) (`N + 1` onto).", D),
    "VectorSpaceOpt.cg_directions_conjugate_until_stop": (
        "4 (adjacent)", "Coercive self-adjoint operator ⇒ conjugacy invariant of the CG "
        "iterates (secondary; useful if the comparison is realized numerically).", D),
    # --- item 4 / §5: Friedrichs positivity ---------------------------------
    "posDef_quadratic_form_lower_bound": (
        "4 / §5", "A positive-definite matrix has a positive form lower bound "
        "`c‖x‖² ≤ ⟨x, M x⟩` — the fibrewise `PosSymOp.pos` input for Friedrichs.", M),
    "Bochner.fourierTransform_nonneg": (
        "4 (adjacent)", "Bochner: a positive-definite function has non-negative Fourier "
        "transform — positivity of the viscous (Fourier-multiplier) symbol.", M),
    # --- item 4 / §3: Schur bounds ------------------------------------------
    "AsaiLargeSieve.schur_row_bound_of_quasiOrthogonal": (
        "4 / §3", "Row-sum Schur bound from quasi-orthogonality — the particle-number-"
        "independent bound on the advection kernel.", D),
    "AsaiLargeSieve.largeSieve_of_schur": (
        "4 / §3", "The row-sum (Schur) test implies the large-sieve inequality — the "
        "abstract `dΓ`/kernel bound in the project's Schur gate.", D),
    # --- item 4: viscous heat flow ------------------------------------------
    "NavierStokes.hasDerivAt_heatFlow": (
        "4", "`∂_t heatFlow = ν Δ heatFlow` — the viscous semigroup generator (the "
        "classical model of `H_visc` on the cutoff).", D),
    "NavierStokes.heatFlow_heatFlow": (
        "4", "The heat flow is a semigroup, `heatFlow s ∘ heatFlow t = heatFlow (s+t)`.", D),
    "NavierStokes.integral_heatKernel_mul_heatKernel": (
        "4", "Heat-kernel convolution identity (the convolution algebra for viscosity).", D),
    "NavierStokes.norm_heatFlow_le": (
        "4", "Contraction bound `‖heatFlow ν t f‖ ≤ M` — the dissipative `L^∞` bound.", D),
    # --- §6: determinant -----------------------------------------------------
    "singular_value_zero_le_spectral_norm": (
        "§6", "`σ₀(Y) ≤ ‖Y‖` (largest singular value bounds the operator norm).", M),
    "spectral_norm_le_singular_value_zero": (
        "§6", "`‖Y‖ ≤ σ₀(Y)` — with the previous, `‖Y‖ = σ₀(Y)`; the norm input to "
        "`σ_min(1+A) ≥ 1 − ‖A‖ > 0` in §6.1.", M),
    "Diaz.det_add_two": (
        "§6 (adjacent)", "`det(X+Y)` for `2×2` in terms of traces — the small-case "
        "template for the `detPoly` expansion of §6.1 (our 3×3 case is the target).", M),
    "Diaz.det_pencil_eq_conic": (
        "§6 (adjacent)", "A determinant pencil is a conic — determinant-as-polynomial "
        "technique, adjacent to `volumePoly`.", D),
    # --- QG spectral edge ----------------------------------------------------
    "ContinuousLinearMap.orthogonal_iSup_eigenspace_ne_zero_eq_ker": (
        "QG", "For compact symmetric `T`, the orthogonal of the span of the non-zero "
        "eigenspaces is `ker T` — the compact-symmetric spectral decomposition consumed "
        "by the band/Ritz ladder.", M),
    "ContinuousLinearMap.le_ker_or_finiteDimensional_of_forall_inf_highPart_orthogonal": (
        "QG", "The high-part finite-dimensionality refinement of the same spectral "
        "decomposition (Ritz truncation).", M),
    "GribovRegion.exists_neg_quadratic_form_of_traceless": (
        "QG (adjacent)", "A traceless Hermitian matrix has a negative direction — a "
        "Gribov-region fact adjacent to the QG quadratic form.", M),
}

ANCHORS = [
    "navier_stokes_global_regularity",
    "sum_of_squares_r_function",
]

# name -> (our leaf-match, why it is NOT needed)
TRIAGE = {
    "QFS.abs_coord_le_norm": (
        "BookProof.HermiteQuadraticEsa.abs_coord_le_norm",
        "Nothing to transcribe.  `EuclideanSpace ℝ (Fin d)` is `PiLp 2 (fun _ : Fin d => ℝ)`, so the "
        "statement is `PiLp.norm_apply_le` (`Mathlib/Analysis/Normed/Lp/PiLp.lean`) composed with "
        "`Real.norm_eq_abs` — verified in-repo by `simpa using PiLp.norm_apply_le (p := 2) x i`.  "
        "The leaf match is a naming coincidence on a generic one-liner; no platform import is owed."),
}


def main():
    ap = argparse.ArgumentParser()
    default = os.path.join(os.path.dirname(WS), "timepiece",
                           "PROVE2ME_REUSABLE_THEOREMS.md")
    ap.add_argument("--out", default=default)
    args = ap.parse_args()

    ok, version, detail = up.auth_probe()
    if not ok:
        print(f"auth failed: {detail}")
        return 2
    rows = [json.loads(x) for x in open(INDEX)]
    by_name = {r["name"]: r for r in rows}

    def fetch(name):
        r = by_name.get(name)
        if not r:
            return None
        t = up.api("GET", f"theorems/{r['id']}") or {}
        return {"id": r["id"], "name": r["name"], "author": r["author"],
                "status": r["status"], "stmt": (t.get("formal_statement") or "").strip()}

    now = datetime.date.today().isoformat()
    env = next((e for e in ((up.api("GET", "environments") or {}).get("environments") or [])
                if e.get("is_default")), {})

    with open(args.out, "w") as f:
        W = f.write
        W("# Reusable theorems from prove2me — frozen search for the offline Lean specialist\n\n")
        W(f"*Search run {now} by the workspace agent against prove2me API `{version}`, default "
          f"environment `{env.get('display_name', '?')}` (`{env.get('mathlib_rev', '?')}`).*\n\n")
        W("> **This file is the only record of the prove2me catalogue that the specialist can "
          "see.** The specialist works inside `../timepiece` with Lean `v4.28.0` and Mathlib "
          "only — no network, no prove2me access, no workspace. Every statement below is the "
          "**verbatim `formal_statement` as stored on the platform** (which elaborates at Lean "
          "`v4.33.1`), so it is a source to transcribe, not to import.\n\n")

        W("## How to use this file\n\n")
        W("1. These theorems are **already proved and machine-verified on prove2me**. They "
          "cannot be `import`ed into timepiece: a Lean `import` binds one toolchain, and the "
          "platform is `v4.33.1` while timepiece is `v4.28.0`.\n")
        W("2. To use one, **state it as a named hypothesis** of the timepiece theorem that "
          "needs it — a `Prop`-valued binder, or a structure field in the style of "
          "`FarisLavine`'s hypotheses — with the platform name and id in a comment. Do **not** "
          "introduce a silent `axiom`; the platform node is the external witness, and the "
          "project's axiom gate (`axiom_gate.lean`, `Audits/`) must keep listing anything "
          "assumed.\n")
        W("3. Restate against the `4.28.0` Mathlib API where it drifted. A `Mathlib-only` row "
          "can be restated directly; a `needs platform-local definitions` row must be "
          "abstracted first (re-declare the minimal notion — a form, a kernel, a coercivity "
          "predicate — and state the result over it).\n")
        W("4. The rows are grouped by the route item they serve, matching the plan items in "
          "`CONSOLIDATED_PLAN.md` (“Cross-platform reuse” and the two “Plan items” sections).\n\n")

        W("## Summary\n\n")
        W("| route item | theorem | author | portability |\n| :-- | :-- | :-- | :-- |\n")
        for name, (item, _why, port) in CATALOG.items():
            r = by_name.get(name)
            author = r["author"] if r else "?"
            W(f"| {item} | `{name}` | {author} | {'Mathlib-only' if port is M else 'needs defs'} |\n")
        W("\n")

        W("## The theorems\n\n")
        for name, (item, why, port) in CATALOG.items():
            r = fetch(name)
            if not r:
                W(f"### `{name}`\n\n_missing from the cached index._\n\n")
                continue
            W(f"### `{r['name']}`\n\n")
            W(f"* **platform id** `{r['id']}` · **status** {r['status']} · "
              f"**author** {r['author']} · **route item** {item}\n")
            W(f"* **what it buys.** {why}\n")
            W(f"* **portability.** {port}\n")
            W(f"* **statement as stored on prove2me (Lean 4.33.1):**\n\n")
            W("```lean\n" + (r["stmt"] or "(empty)") + "\n```\n\n")

        W("## Anti-reuse — `Proved` badges that must NOT be cited\n\n")
        W("Both are marked `Proved` and both are worthless for this plan. Recorded so the trap "
          "is not rediscovered.\n\n")
        for name in ANCHORS:
            r = fetch(name)
            if not r:
                continue
            W(f"### `{r['name']}` — do not cite\n\n")
            W(f"* platform id `{r['id']}` · author {r['author']}\n")
            W("```lean\n" + (r["stmt"] or "(empty)") + "\n```\n\n")
        W("* `navier_stokes_global_regularity` never states the momentum equation — it only "
          "asserts the existence of *some* smooth `u` with `u 0 = u₀`, so it says nothing "
          "about Navier–Stokes.\n")
        W("* `sum_of_squares_r_function` has conclusion literally `True`.\n\n")

        W("## Leaf-name triage — checked and *not* needed\n\n")
        W("A pipeline stub can share its leaf name with another user's `Proved` node and still be no "
          "reuse candidate, because timepiece's **own** Mathlib (`v4.28.0`) already proves the fact. "
          "One such hit is recorded so it is not re-investigated.\n\n")
        for name, (leaf, why) in TRIAGE.items():
            r = fetch(name)
            if not r:
                continue
            W(f"### `{r['name']}` — do not cite (already in timepiece's Mathlib)\n\n")
            W(f"* platform id `{r['id']}` · status {r['status']} · author {r['author']} · "
              f"leaf-matches `{leaf}`\n\n```lean\n{r['stmt']}\n```\n\n")
            W(f"* **Verdict.**  {why}\n\n")

        W("## What was *not* found\n\n")
        W("* No platform theorem states **Faris–Lavine**, an **essential self-adjointness "
          "criterion**, a **Friedrichs extension**, **second quantization / `dΓ`**, a "
          "**Fock-space** construction, or a **Kato–Rellich** bound. Those instruments remain "
          "the project's own (`ChapterFarisLavineCore`, `ChapterQgOuterFockFarisLavine`, …); "
          "nothing on the platform duplicates them.\n")
        W("* No platform theorem asserts **global regularity of the Navier–Stokes equation** "
          "(see the anti-reuse section), nor **any mass gap**.\n")

    print(f"wrote {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
