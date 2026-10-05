-- Generated from ChapterNsCutoffUniformity.lean — solution of BookProof.NsCutoffUniformity.norm_coeff_C_mul_X_mul_X_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity




open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {n : ℕ}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (a b : ι) (m : ι →₀ ℕ) :
    ‖coeff m (C c * (X a * X b) : MvPolynomial ι ℂ)‖ ≤ ‖c‖ := by

  classical
  have hx : (X a * X b : MvPolynomial ι ℂ)
      = monomial (Finsupp.single a 1 + Finsupp.single b 1) 1 := by
    rw [X, X, monomial_mul, one_mul]
  rw [hx, coeff_C_mul, norm_mul, coeff_monomial]
  split <;> simp
