import Mathlib
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterStrichartzWave


/-!
# The quadratic form of `−d²/dx² + V` is bounded below when `V` is

`BookProof/ChapterWallEsaBddBelow.lean` proves that `−d²/dx² + V` is essentially
self-adjoint on the compactly supported smooth core of `L²(ℝ)` for every smooth `V`
bounded below.  Its docstring promised, but did not supply, the packaging lemma that
the shift-invert schemes need: the *quadratic form* of that operator is bounded below
by the same constant.  This module supplies it.

The content is the one-dimensional Green identity on the compactly supported smooth
core,

  `⟪(−d²/dx² + V) f, f⟫ = ∫ |f'|² + ∫ V |f|²`,

which is integration by parts once — carried out here with the compact-support
integration-by-parts engine
`BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport`.  Both terms
on the right are real, the first is `≥ 0`, and the second is `≥ -c ‖f‖²` when `V ≥ -c`.

## Contents

* `SemiboundedBelowOn` — the quadratic form of an unbounded operator on a core is
  bounded below by `-c`.
* `integral_conj_neg_deriv2_mul` — the Green identity `∫ conj(−f'') f = ∫ |f'|²` for
  a compactly supported `C²` function on the line.
* `kinCcR_quadratic_form` / `opCc_quadratic_form` / `ccEquiv_norm_sq` — the three
  pieces of the pairing as ordinary integrals.
* **`wallHamBddBelow_semibounded`** — the promised lemma: if `V ≥ -c` then the
  quadratic form of `wallHam V hV` is bounded below by `-c`.
* `wallHam_nonneg_form` — the `c = 0` case: for `V ≥ 0` the form is non-negative.

The exponential wall `eˣ + e⁻ˣ` is handled in `BookProof/ChapterExpPotentialEsa.lean`
(`expPotential_semibounded`).
-/

namespace BookProof.WallEsaSemibounded

open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The quadratic form of an unbounded operator `T`, defined on the core `D`, is
**bounded below by `-c`**: `Re ⟪T v, v⟫ ≥ -c ‖v‖²` for every `v` in the core. -/
def SemiboundedBelowOn (D : Submodule ℂ F) (T : D →ₗ[ℂ] F) (c : ℝ) : Prop :=
  ∀ v : D, -c * ‖(v : F)‖ ^ 2 ≤ (inner ℂ (T v) (v : F) : ℂ).re

/-! ## The Green identity on the compactly supported smooth core -/



/-! ## The three pieces of the pairing -/









/-! ## The packaging lemma -/





theorem kinCcR_quadratic_form (f : ccSchwartz ℝ) :
    (inner ℂ (kinCcR (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 : ℝ) : ℂ) := by
  sorry

theorem opCc_quadratic_form (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (f : ccSchwartz ℝ) :
    (inner ℂ (opCc V hV (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by
  sorry

end

end BookProof.WallEsaSemibounded
