-- Generated from ChapterNsCutoffUniformity.lean — solution of BookProof.NsCutoffUniformity.norm_coeff_redVisc_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Theorems.Thm_BookProof_NsCutoffUniformity_norm_coeff_X_le
import Theorems.Thm_BookProof_NsCutoffUniformity_norm_coeff_C_mul_X_le
import Theorems.Thm_BookProof_NsCutoffUniformity_abs_visc_coeff_le
open BookProof.NsCutoffUniformity




open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {n : ℕ}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) {Λ : ℝ} {k : Fin 3 → ℝ} (hΛ : 0 ≤ Λ)
    (hk : ∀ j, |k j| ≤ Λ) (p : Fin n) (i : Fin 3) (m : Fin (n * 6) →₀ ℕ) :
    ‖coeff m (redVisc nu k n p i)‖ ≤ 1 + 3 * |nu| * Λ ^ 2 := by

  rw [redVisc, coeff_add]
  refine (norm_add_le _ _).trans ?_
  gcongr
  · exact norm_coeff_X_le _ _
  · refine (norm_coeff_C_mul_X_le _ _ _).trans ?_
    rw [Complex.norm_real, Real.norm_eq_abs]
    exact abs_visc_coeff_le hΛ hk
