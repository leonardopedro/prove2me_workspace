-- Generated from ChapterComplexShiftCore.lean — solution of BookProof.HashimotoShiftInvert.norm_cshiftMap_ge
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Theorems.Thm_BookProof_HashimotoShiftInvert_cshiftMap_apply
import Theorems.Thm_BookProof_FarisLavine_quadForm_im
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A) (γ : ℂ) (x : Dom) :
    |γ.im| * ‖(x : F)‖ ≤ ‖cshiftMap A γ x‖ := by

  have him : (inner ℂ (x : F) (cshiftMap A γ x) : ℂ).im = γ.im * ‖(x : F)‖ ^ 2 := by
    rw [cshiftMap_apply, inner_sub_right, inner_smul_right, Complex.sub_im, Complex.mul_im,
      inner_self_eq_norm_sq_to_K, quadForm_im A hsym x]
    simp [← Complex.ofReal_pow]
  have h2 : |(inner ℂ (x : F) (cshiftMap A γ x) : ℂ).im| ≤ ‖(x : F)‖ * ‖cshiftMap A γ x‖ :=
    le_trans (Complex.abs_im_le_norm _) (norm_inner_le_norm _ _)
  rw [him, abs_mul, abs_of_nonneg (by positivity : (0:ℝ) ≤ ‖(x : F)‖ ^ 2)] at h2
  rcases eq_or_lt_of_le (norm_nonneg (x : F)) with h0 | hpx
  · rw [← h0]; simp
  · nlinarith [abs_nonneg γ.im]
