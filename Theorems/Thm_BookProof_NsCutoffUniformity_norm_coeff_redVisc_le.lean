-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.norm_coeff_redVisc_le
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.norm_coeff_redVisc_le (nu : ℝ) {Λ : ℝ} {k : Fin 3 → ℝ} (hΛ : 0 ≤ Λ)
    (hk : ∀ j, |k j| ≤ Λ) (p : Fin n) (i : Fin 3) (m : Fin (n * 6) →₀ ℕ) :
    ‖coeff m (redVisc nu k n p i)‖ ≤ 1 + 3 * |nu| * Λ ^ 2 := by sorry
