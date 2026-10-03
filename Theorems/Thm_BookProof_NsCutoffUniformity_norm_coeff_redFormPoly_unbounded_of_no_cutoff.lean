-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.norm_coeff_redFormPoly_unbounded_of_no_cutoff
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Definitions.Def_ChapterA4

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.norm_coeff_redFormPoly_unbounded_of_no_cutoff (nu : ℝ) (C₀ : ℝ) :
    ∃ (k : Fin 3 → ℝ) (m : Fin (1 * 6) →₀ ℕ) (p : Fin 1) (r : Fin 7),
      C₀ < ‖coeff m (redFormPoly nu k 1 p r)‖ := by sorry
