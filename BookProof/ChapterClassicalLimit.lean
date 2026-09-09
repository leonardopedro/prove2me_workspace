import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure"
— calculable functions are dense in the `L²` measure (the classical-limit
density remark)

This file formalizes the self-contained mathematical claim of the section
*"11. Conditions for the classical limit of Quantum Mechanics"* (`book.tex`
line ~2081):

> *"Step, polynomial or smooth functions are dense in the `L²` measure. Any
> bounded function in a compact domain can be approximated in the `L²` measure
> … by these calculable functions."*

The book uses this to explain why "calculable" (step / polynomial / smooth)
functions are useful in the classical (macroscopic) limit even though a generic
`L²` element is not calculable: they form a *dense* subset, so every state can
be approximated arbitrarily well.

We work over a compact set `s ⊆ ℝ` (the book's "compact domain") equipped with
any finite, weakly-regular Borel measure `μ`, and formalize the three families
the book lists as dense in `Lᵖ` (stated at the book's `p = 2`, though the
`simpleFunc` result holds for any `p ≠ ∞`):

* **step functions** — the (a.e. classes of) *simple* functions,
  `simpleFunc_dense_L2`;
* **continuous functions** — `continuousMap_denseRange_L2`
  (the continuous-map embedding `C(s, ℝ) → Lᵖ` has dense range);
* **polynomial functions** — `polynomial_denseRange_L2`, obtained by combining
  Stone–Weierstrass (`polynomialFunctions.topologicalClosure = ⊤`, i.e.
  polynomials are dense in `C(s, ℝ)`) with the dense embedding of continuous
  functions into `Lᵖ`.

Because every polynomial is smooth, `polynomial_denseRange_L2` simultaneously
witnesses the density of the smooth functions (they contain the polynomials),
so all three of the book's "calculable" families are dense.

The book's closing statement — that any bounded function on the compact domain
can be `L²`-approximated by such calculable functions — is exactly the
`ε`-form `exists_polynomial_approx_L2`: for every `F ∈ L²(μ)` and every `ε > 0`
there is a polynomial `q` with `‖q|ₛ − F‖₂ < ε`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open MeasureTheory Polynomial

namespace BookProof.ChapterClassicalLimit

noncomputable section

variable {s : Set ℝ} [CompactSpace s]
  (μ : Measure s) [IsFiniteMeasure μ] [μ.WeaklyRegular]

omit [CompactSpace s] [IsFiniteMeasure μ] [μ.WeaklyRegular] in
/-- **Step functions are dense in `Lᵖ`.**  The (a.e. classes of) simple
functions form a dense subset of `Lᵖ(μ)` for any `p ≠ ∞` (here `p = 2`).
This is the book's "step functions are dense in the `L²` measure". -/
theorem simpleFunc_dense_L2 :
    Dense (X := Lp ℝ 2 μ) (↑(Lp.simpleFunc ℝ 2 μ)) :=
  Lp.simpleFunc.dense (by norm_num)

/-- **Continuous functions are dense in `Lᵖ`.**  On a compact domain the
continuous-map embedding `C(s, ℝ) → Lᵖ(μ)` has dense range. -/
theorem continuousMap_denseRange_L2 :
    DenseRange (ContinuousMap.toLp (E := ℝ) 2 μ ℝ) :=
  ContinuousMap.toLp_denseRange ℝ μ ℝ (by norm_num)

/-- **Polynomials are dense in `C(s, ℝ)`** (Stone–Weierstrass): the inclusion
of the subalgebra of polynomial functions on a compact `s ⊆ ℝ` into `C(s, ℝ)`
has dense range. -/
theorem polynomialFunctions_val_denseRange :
    DenseRange ((polynomialFunctions s).val) := by
  rw [DenseRange, dense_iff_closure_eq]
  have hr : Set.range ⇑(polynomialFunctions s).val = ((polynomialFunctions s) : Set _) := by
    rw [← AlgHom.coe_range, Subalgebra.range_val]
  rw [hr]
  have h := polynomialFunctions.topologicalClosure s
  have hc := Subalgebra.topologicalClosure_coe (polynomialFunctions s)
  rw [h] at hc
  simpa using hc.symm

/-- **Polynomial functions are dense in `Lᵖ`.**  Composing Stone–Weierstrass
(`polynomialFunctions_val_denseRange`) with the dense continuous embedding
(`continuousMap_denseRange_L2`): the map sending a polynomial function to its
`Lᵖ` class has dense range.  This is the book's "polynomial functions are dense
in the `L²` measure"; since polynomials are smooth it also witnesses the
density of the smooth functions. -/
theorem polynomial_denseRange_L2 :
    DenseRange (fun p : (polynomialFunctions s) =>
      ContinuousMap.toLp (E := ℝ) 2 μ ℝ ((polynomialFunctions s).val p)) :=
  (continuousMap_denseRange_L2 μ).comp
    (polynomialFunctions_val_denseRange (s := s))
    (ContinuousMap.toLp 2 μ ℝ).continuous

/-- **Any `L²` state is approximated by a polynomial** (the book's headline:
any bounded function on a compact domain can be `L²`-approximated by calculable
functions).  For every `F ∈ L²(μ)` and every `ε > 0` there is a polynomial `q`
whose restriction `q|ₛ`, viewed in `L²`, satisfies `‖q|ₛ − F‖₂ < ε`. -/
theorem exists_polynomial_approx_L2 (F : Lp ℝ 2 μ) {ε : ℝ} (hε : 0 < ε) :
    ∃ q : ℝ[X], dist (ContinuousMap.toLp (E := ℝ) 2 μ ℝ (q.toContinuousMapOn s)) F < ε := by
  obtain ⟨p, hp⟩ := (polynomial_denseRange_L2 μ).exists_dist_lt F hε
  obtain ⟨q, -, hq⟩ := p.2
  refine ⟨q, ?_⟩
  rw [dist_comm] at hp
  have hqeq : q.toContinuousMapOn s = ((polynomialFunctions s).val p) := hq
  rw [hqeq]
  exact hp

end

end BookProof.ChapterClassicalLimit
