-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.norm_coeff_redAdvectPoly_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Definitions.Def_ChapterA4

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.norm_coeff_redAdvectPoly_le {Λ : ℝ} {k : Fin 3 → ℝ}
    (hk : ∀ j, |k j| ≤ Λ) (p : Fin n) (i : Fin 3) (m : Fin (n * 6) →₀ ℕ) :
    ‖coeff m (redAdvectPoly k n p i)‖ ≤ 3 * Λ := by sorry
