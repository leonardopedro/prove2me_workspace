-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.norm_coeff_redMomentumPoly_le
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.norm_coeff_redMomentumPoly_le {Λ : ℝ} {k : Fin 3 → ℝ}
    (hk : ∀ j, |k j| ≤ Λ) (p : Fin n) (m : Fin (n * 6) →₀ ℕ) :
    ‖coeff m (redMomentumPoly k n p)‖ ≤ 3 * Λ := by sorry
