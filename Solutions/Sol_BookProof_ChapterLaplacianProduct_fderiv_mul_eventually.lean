-- Generated from ChapterLaplacianProduct.lean — solution of BookProof.ChapterLaplacianProduct.fderiv_mul_eventually
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
open BookProof.ChapterLaplacianProduct




open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {f g : E → ℝ} {x : E}
    (hf : ContDiffAt ℝ 2 f x) (hg : ContDiffAt ℝ 2 g x) :
    (fderiv ℝ fun y : E => f y * g y) =ᶠ[nhds x]
      fun y => g y • fderiv ℝ f y + f y • fderiv ℝ g y := by

  have hfe : ∀ᶠ y in nhds x, DifferentiableAt ℝ f y := by
    filter_upwards [hf.eventually (by simp)] with y hy using hy.differentiableAt (by norm_num)
  have hge : ∀ᶠ y in nhds x, DifferentiableAt ℝ g y := by
    filter_upwards [hg.eventually (by simp)] with y hy using hy.differentiableAt (by norm_num)
  filter_upwards [hfe, hge] with y hy hy'
  have h := fderiv_mul (𝕜 := ℝ) (c := f) (d := g) hy hy'
  rw [show (fun y : E => f y * g y) = f * g from rfl, h]
  abel
