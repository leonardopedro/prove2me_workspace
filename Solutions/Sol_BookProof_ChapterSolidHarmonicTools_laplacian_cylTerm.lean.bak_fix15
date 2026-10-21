-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.laplacian_cylTerm
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_hasFDerivAt_rclmPow
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_contDiff_rclmPow
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_laplacian_rclmPow
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_sum_inner_sq
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_fderiv_normSqPow
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_contDiff_normSqPow
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_laplacian_normSqPow
import Theorems.Thm_BookProof_ChapterLaplacianProduct_laplacian_mul
import Theorems.Thm_BookProof_ChapterLaplacianProduct_sum_inner_mul_apply
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (e : E) (he : ‖e‖ = 1) (j m : ℕ) (x : E) :
    (Δ fun y : E => (⟪e, y⟫_ℝ) ^ j * (‖y‖ ^ 2) ^ m) x
      = (j : ℝ) * ((j : ℝ) - 1) * (⟪e, x⟫_ℝ) ^ (j - 2) * (‖x‖ ^ 2) ^ m
        + (4 * m * ((m : ℝ) - 1) + 2 * (Module.finrank ℝ E) * m + 4 * j * m)
            * (⟪e, x⟫_ℝ) ^ j * (‖x‖ ^ 2) ^ (m - 1) := by

  have hf : ContDiffAt ℝ 2 (fun y : E => (⟪e, y⟫_ℝ) ^ j) x :=
    (contDiff_rclmPow (innerCLM E e) j).contDiffAt
  have hg : ContDiffAt ℝ 2 (fun y : E => (‖y‖ ^ 2) ^ m) x := (contDiff_normSqPow m).contDiffAt
  have hprod := laplacian_mul hf hg
  have hlapf : (Δ fun y : E => (⟪e, y⟫_ℝ) ^ j) x
      = (j : ℝ) * ((j : ℝ) - 1) * (⟪e, x⟫_ℝ) ^ (j - 2) := by
    have key := laplacian_rclmPow (innerCLM E e) j x
    simp only [innerCLM_apply] at key
    rw [key, sum_inner_sq e, he]
    ring
  have hlapg := laplacian_normSqPow (E := E) m x
  have hcross : ∑ i, fderiv ℝ (fun y : E => (⟪e, y⟫_ℝ) ^ j) x ((stdOrthonormalBasis ℝ E) i)
      * fderiv ℝ (fun y : E => (‖y‖ ^ 2) ^ m) x ((stdOrthonormalBasis ℝ E) i)
      = 2 * (j : ℝ) * m * (⟪e, x⟫_ℝ) ^ j * (‖x‖ ^ 2) ^ (m - 1) := by
    have hfd := (hasFDerivAt_rclmPow (innerCLM E e) j x).fderiv
    simp only [innerCLM_apply] at hfd
    rw [hfd, fderiv_normSqPow]
    have hsum : ∑ i, ((j : ℝ) * (⟪e, x⟫_ℝ) ^ (j - 1) * (2 * m * (‖x‖ ^ 2) ^ (m - 1)))
        * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ * (innerCLM E e) ((stdOrthonormalBasis ℝ E) i))
        = ((j : ℝ) * (⟪e, x⟫_ℝ) ^ (j - 1) * (2 * m * (‖x‖ ^ 2) ^ (m - 1))) * ⟪e, x⟫_ℝ := by
      rw [← Finset.mul_sum, sum_inner_mul_apply (innerCLM E e) x]
      simp
    have hrw : ∑ i, (((j : ℝ) * (⟪e, x⟫_ℝ) ^ (j - 1)) • innerCLM E e) ((stdOrthonormalBasis ℝ E) i)
        * ((2 * m * (‖x‖ ^ 2) ^ (m - 1)) • innerCLM E x) ((stdOrthonormalBasis ℝ E) i)
        = ∑ i, ((j : ℝ) * (⟪e, x⟫_ℝ) ^ (j - 1) * (2 * m * (‖x‖ ^ 2) ^ (m - 1)))
            * (⟪x, (stdOrthonormalBasis ℝ E) i⟫_ℝ
              * (innerCLM E e) ((stdOrthonormalBasis ℝ E) i)) := by
      refine Finset.sum_congr rfl fun i _ => ?_
      simp only [ContinuousLinearMap.coe_smul', Pi.smul_apply, smul_eq_mul, innerCLM_apply]
      ring
    rw [hrw, hsum]
    rcases j with _ | j
    · simp
    · simp only [Nat.add_sub_cancel]
      ring
  rw [hprod, hlapf, hlapg, hcross]
  ring
