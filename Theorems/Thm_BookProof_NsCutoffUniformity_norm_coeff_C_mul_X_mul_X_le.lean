-- Generated from ChapterNsCutoffUniformity.lean — theorem BookProof.NsCutoffUniformity.norm_coeff_C_mul_X_mul_X_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Definitions.Def_ChapterA4
open BookProof.NsCutoffUniformity

variable {n : ℕ}
variable {ι : Type*}



open MvPolynomial BookProof.NsFullEuler

noncomputable section


theorem BookProof.NsCutoffUniformity.norm_coeff_C_mul_X_mul_X_le (c : ℂ) (a b : ι) (m : ι →₀ ℕ) :
    ‖coeff m (C c * (X a * X b) : MvPolynomial ι ℂ)‖ ≤ ‖c‖ := by sorry
