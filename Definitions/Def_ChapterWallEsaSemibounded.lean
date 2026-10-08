import Definitions.Def_ChapterWallEsaBddBelow
import Definitions.Def_ChapterSchrodingerCutoffEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterStrichartzWave
import Mathlib


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
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The quadratic form of an unbounded operator `T`, defined on the core `D`, is
**bounded below by `-c`**: `Re ⟪T v, v⟫ ≥ -c ‖v‖²` for every `v` in the core. -/
def SemiboundedBelowOn (D : Submodule ℂ F) (T : D →ₗ[ℂ] F) (c : ℝ) : Prop :=
  ∀ v : D, -c * ‖(v : F)‖ ^ 2 ≤ (inner ℂ (T v) (v : F) : ℂ).re

/-! ## The Green identity on the compactly supported smooth core -/

comp_left (g := fun z : ℂ => ((‖z‖ ^ 2 x)cRdrintegral_congr_ae ?_
  filter_upwmu x‖ ^ 2 := by
    rw [← integral_const_mul]
    exact integral_mono hIc hIV fun x => by
      have := hVc x
      nlinarith [sq_nonneg ‖(f : 𝓢(ℝ, ℂ)) x‖, norm_nonneg ((f : 𝓢(ℝ, ℂ)) x)]
  simp only [wallHam, LinearMap.add_apply, inner_add_left, hk, hp, hn]
  simp only [Complex.add_re, Complex.ofReal_re]
  linarith

/-- The non-negative case: for `V ≥ 0` the quadratic form of `−d²/dx² + V` is
non-negative on the compactly supported smooth core. -/
theorem wallHam_nonneg_form (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (hVnn : ∀ x, 0 ≤ V x) :
    SemiboundedBelowOn (ccDomain ℝ) (wallHam V hV) 0 :=
  wallHamBddBelow_semibounded V hV fun x => by simpa using hVnn x

end

end BookProof.WallEsaSemibounded
