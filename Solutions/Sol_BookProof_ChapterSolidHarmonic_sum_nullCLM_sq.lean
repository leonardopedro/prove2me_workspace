-- Generated from ChapterSolidHarmonic.lean — solution of BookProof.ChapterSolidHarmonic.sum_nullCLM_sq
import Mathlib
import Definitions.Def_ChapterSolidHarmonic
import Theorems.Thm_BookProof_ChapterLaplacianProduct_sum_inner_mul_apply
import Theorems.Thm_BookProof_ChapterSolidHarmonicTools_sum_inner_sq
open BookProof.ChapterSolidHarmonic




open Laplacian InnerProductSpace Polynomial
open BookProof.ChapterRadialLaplacian BookProof.ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools BookProof.ChapterLegendrePolynomial
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {u v : E} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (huv : ⟪u, v⟫_ℝ = 0) :
    ∑ i, (nullCLM u v (stdOrthonormalBasis ℝ E i)) ^ 2 = 0 := by

  have h1 : ∑ i, (⟪u, (stdOrthonormalBasis ℝ E) i⟫_ℝ) ^ 2 = 1 := by
    rw [sum_inner_sq u, hu]; norm_num
  have h2 : ∑ i, (⟪v, (stdOrthonormalBasis ℝ E) i⟫_ℝ) ^ 2 = 1 := by
    rw [sum_inner_sq v, hv]; norm_num
  have h3 : ∑ i, ⟪u, (stdOrthonormalBasis ℝ E) i⟫_ℝ * ⟪v, (stdOrthonormalBasis ℝ E) i⟫_ℝ = 0 := by
    have h := sum_inner_mul_apply (innerCLM E v) u
    simp only [innerCLM_apply] at h
    rw [h, real_inner_comm]
    exact huv
  have expand : ∀ i, (nullCLM u v (stdOrthonormalBasis ℝ E i)) ^ 2
      = (((⟪u, (stdOrthonormalBasis ℝ E) i⟫_ℝ) ^ 2 - (⟪v, (stdOrthonormalBasis ℝ E) i⟫_ℝ) ^ 2 : ℝ)
          : ℂ)
        + Complex.I * ((2 * ⟪u, (stdOrthonormalBasis ℝ E) i⟫_ℝ
            * ⟪v, (stdOrthonormalBasis ℝ E) i⟫_ℝ : ℝ) : ℂ) := by
    intro i
    rw [nullCLM_apply]
    push_cast
    ring_nf
    rw [Complex.I_sq]
    ring
  simp only [expand]
  rw [Finset.sum_add_distrib, ← Complex.ofReal_sum, ← Finset.mul_sum, ← Complex.ofReal_sum]
  have hsub : ∑ i, ((⟪u, (stdOrthonormalBasis ℝ E) i⟫_ℝ) ^ 2
      - (⟪v, (stdOrthonormalBasis ℝ E) i⟫_ℝ) ^ 2) = 0 := by
    rw [Finset.sum_sub_distrib, h1, h2, sub_self]
  have hmix : ∑ i, (2 * ⟪u, (stdOrthonormalBasis ℝ E) i⟫_ℝ
      * ⟪v, (stdOrthonormalBasis ℝ E) i⟫_ℝ) = 0 := by
    simp only [mul_assoc]
    rw [← Finset.mul_sum, h3, mul_zero]
  rw [hsub, hmix]
  simp
