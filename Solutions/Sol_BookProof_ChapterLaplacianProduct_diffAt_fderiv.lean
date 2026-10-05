-- Generated from ChapterLaplacianProduct.lean — solution of BookProof.ChapterLaplacianProduct.diffAt_fderiv
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct




open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {f : E → ℝ} {x : E} (h : ContDiffAt ℝ 2 f x) :
    DifferentiableAt ℝ (fderiv ℝ f) x := by

  obtain ⟨u, hu, hfu⟩ := h.contDiffOn (m := 2) le_rfl (by simp)
  obtain ⟨v, hvu, hvo, hqv⟩ := mem_nhds_iff.1 hu
  have h2 : ContDiffOn ℝ 1 (fderiv ℝ f) v := (hfu.mono hvu).fderiv_of_isOpen hvo (by norm_num)
  exact (h2.differentiableOn (by norm_num)).differentiableAt (hvo.mem_nhds hqv)
