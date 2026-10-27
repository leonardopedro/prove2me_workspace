-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.hasFDerivAt_cylTerm
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_hasFDerivAt_rclmPow
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_fderiv_normSqPow
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_contDiff_normSqPow
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (e : E) (j m : ℕ) (x : E) :
    HasFDerivAt (fun y : E => (⟪e, y⟫_ℝ) ^ j * (‖y‖ ^ 2) ^ m)
      (((j : ℝ) * (⟪e, x⟫_ℝ) ^ (j - 1) * (‖x‖ ^ 2) ^ m) • innerCLM E e
        + (2 * m * (⟪e, x⟫_ℝ) ^ j * (‖x‖ ^ 2) ^ (m - 1)) • innerCLM E x) x := by

  have hf : HasFDerivAt (fun y : E => (⟪e, y⟫_ℝ) ^ j)
      (((j : ℝ) * (⟪e, x⟫_ℝ) ^ (j - 1)) • (innerCLM E e)) x :=
    hasFDerivAt_rclmPow (innerCLM E e) j x
  have hg : HasFDerivAt (fun y : E => (‖y‖ ^ 2) ^ m)
      ((2 * m * (‖x‖ ^ 2) ^ (m - 1)) • innerCLM E x) x := by
    have hcd : ContDiff ℝ 2 fun y : E => (‖y‖ ^ 2) ^ m := contDiff_normSqPow m
    have hdiff : DifferentiableAt ℝ (fun y : E => (‖y‖ ^ 2) ^ m) x :=
      (hcd.differentiable (by norm_num)).differentiableAt
    rw [← fderiv_normSqPow m x]
    exact hdiff.hasFDerivAt
  have h := hf.mul hg
  convert h using 1
    <;> first
      | rfl
      | (ext u; simp only [ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
          smul_eq_mul, innerCLM_apply])
    <;> first | ring | (simp [mul_assoc, mul_comm, mul_left_comm]; ring)
