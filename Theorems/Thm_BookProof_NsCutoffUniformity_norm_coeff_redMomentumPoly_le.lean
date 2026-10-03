-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.norm_coeff_redMomentumPoly_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Definitions.Def_ChapterA4

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.norm_coeff_redMomentumPoly_le {Λ : ℝ} {k : Fin 3 → ℝ}
    (hk : ∀ j, |k j| ≤ Λ) (p : Fin n) (m : Fin (n * 6) →₀ ℕ) :
    ‖coeff m (redMomentumPoly k n p)‖ ≤ 3 * Λ := by sorry
