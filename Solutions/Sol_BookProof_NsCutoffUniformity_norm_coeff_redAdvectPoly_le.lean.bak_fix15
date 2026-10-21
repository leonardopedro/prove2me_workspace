-- Generated from ChapterNsCutoffUniformity.lean — solution of BookProof.NsCutoffUniformity.norm_coeff_redAdvectPoly_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
import Theorems.Thm_BookProof_NsCutoffUniformity_norm_coeff_C_mul_X_mul_X_le
open BookProof.NsCutoffUniformity




open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {n : ℕ}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {Λ : ℝ} {k : Fin 3 → ℝ}
    (hk : ∀ j, |k j| ≤ Λ) (p : Fin n) (i : Fin 3) (m : Fin (n * 6) →₀ ℕ) :
    ‖coeff m (redAdvectPoly k n p i)‖ ≤ 3 * Λ := by

  rw [redAdvectPoly, coeff_sum]
  refine (norm_sum_le _ _).trans ?_
  calc ∑ j : Fin 3, ‖coeff m (C ((k j : ℝ) : ℂ) * (X (ruIdx p j) * X (ruIdx p i)))‖
      ≤ ∑ _j : Fin 3, Λ := by
        refine Finset.sum_le_sum fun j _ => ?_
        refine (norm_coeff_C_mul_X_mul_X_le _ _ _ _).trans ?_
        rw [Complex.norm_real, Real.norm_eq_abs]
        exact hk j
    _ = 3 * Λ := by simp [Finset.sum_const]
