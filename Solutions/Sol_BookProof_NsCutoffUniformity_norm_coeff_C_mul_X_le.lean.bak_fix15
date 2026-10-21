-- Generated from ChapterNsCutoffUniformity.lean — solution of BookProof.NsCutoffUniformity.norm_coeff_C_mul_X_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity




open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {n : ℕ}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (a : ι) (m : ι →₀ ℕ) :
    ‖coeff m (C c * X a : MvPolynomial ι ℂ)‖ ≤ ‖c‖ := by

  classical
  rw [coeff_C_mul, norm_mul, coeff_X']
  split <;> simp
