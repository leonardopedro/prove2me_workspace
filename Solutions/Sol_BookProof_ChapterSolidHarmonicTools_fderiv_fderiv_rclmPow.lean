-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.fderiv_fderiv_rclmPow
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_hasFDerivAt_rclmPow
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (L : E →L[ℝ] ℝ) (k : ℕ) (x v w : E) :
    fderiv ℝ (fderiv ℝ fun y => (L y) ^ k) x v w
      = (k : ℝ) * ((k : ℝ) - 1) * (L x) ^ (k - 2) * L v * L w := by

  have hfd : (fderiv ℝ fun y : E => (L y) ^ k)
      = fun y => ((k : ℝ) * (L y) ^ (k - 1)) • (L : E →L[ℝ] ℝ) := by
    funext y; exact (hasFDerivAt_rclmPow L k y).fderiv
  rw [hfd]
  have hc : HasFDerivAt (fun y : E => (k : ℝ) * (L y) ^ (k - 1))
      (((k : ℝ) * ((k - 1 : ℕ) : ℝ) * (L x) ^ (k - 1 - 1)) • (L : E →L[ℝ] ℝ)) x := by
    have h := (hasFDerivAt_rclmPow L (k - 1) x).const_mul (k : ℝ)
    convert h using 1
      <;> first
        | rfl
        | simp only [← Nat.cast_smul_eq_nsmul ℝ, smul_smul, mul_assoc]
        | (ext u; simp only [smul_apply, smul_eq_mul, nsmul_eq_mul, mul_assoc])
  rw [(hc.smul_const (L : E →L[ℝ] ℝ)).fderiv]
  simp only [ContinuousLinearMap.smulRight_apply, ContinuousLinearMap.coe_smul', Pi.smul_apply,
    smul_eq_mul]
  rcases k with _ | _ | k
  · simp
  · simp
  · push_cast; ring_nf
