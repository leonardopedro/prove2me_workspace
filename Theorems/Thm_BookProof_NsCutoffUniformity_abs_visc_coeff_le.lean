-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.abs_visc_coeff_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Definitions.Def_ChapterA4

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.abs_visc_coeff_le {nu Λ : ℝ} {k : Fin 3 → ℝ} (hΛ : 0 ≤ Λ) (hk : ∀ j, |k j| ≤ Λ) :
    |nu * ∑ j : Fin 3, (k j) ^ 2| ≤ 3 * |nu| * Λ ^ 2 := by sorry
