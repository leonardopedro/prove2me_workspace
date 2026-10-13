-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.sum_inner_sq
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
import Definitions.Def_ChapterRadialLaplacian
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (e : E) :
    ∑ i, (⟪e, (stdOrthonormalBasis ℝ E) i⟫_ℝ) ^ 2 = ‖e‖ ^ 2 := by

  have h := (stdOrthonormalBasis ℝ E).sum_inner_mul_inner e e
  simp only [real_inner_comm e] at h
  simp only [sq]
  rw [h, real_inner_self_eq_norm_sq]
  ring
