-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.dim_mul_norm_le_shiftNorm
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_norm_sq_le_quadForm_harm
import Theorems.Thm_BookProof_GaussCoreQuadBounds_re_inner_symm
import Theorems.Thm_BookProof_GaussCoreQuadBounds_inner_harmP_re
import Theorems.Thm_BookProof_GaussCoreQuadBounds_shiftNorm_nonneg
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin D) ℂ) :
    ((D : ℝ) / 2 + 1) * ‖pgLp p‖ ≤ shiftNorm p := by

  have hlow := norm_sq_le_quadForm_harm p
  have hcs : (inner ℂ (pgLp p) (pgLp (harmP p) + pgLp p) : ℂ).re
      ≤ ‖pgLp p‖ * shiftNorm p := by
    refine le_trans (Complex.re_le_norm _) ?_
    simpa [shiftNorm] using norm_inner_le_norm (𝕜 := ℂ) (pgLp p) (pgLp (harmP p) + pgLp p)
  have hexp : (inner ℂ (pgLp p) (pgLp (harmP p) + pgLp p) : ℂ).re
      = quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ + ‖pgLp p‖ ^ 2 := by
    rw [inner_add_right, Complex.add_re, re_inner_symm (pgLp p) (pgLp (harmP p)),
      inner_harmP_re]
    congr 1
    exact inner_self_eq_norm_sq (𝕜 := ℂ) (pgLp p)
  rcases eq_or_lt_of_le (norm_nonneg (pgLp p)) with h0 | h0
  · rw [← h0]
    simpa using shiftNorm_nonneg p
  · have hkey : ((D : ℝ) / 2 + 1) * ‖pgLp p‖ ^ 2 ≤ ‖pgLp p‖ * shiftNorm p := by
      rw [hexp] at hcs
      nlinarith
    exact le_of_mul_le_mul_right (by nlinarith : ((D : ℝ) / 2 + 1) * ‖pgLp p‖ * ‖pgLp p‖
      ≤ shiftNorm p * ‖pgLp p‖) h0
