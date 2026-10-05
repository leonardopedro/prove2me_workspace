-- Generated from ChapterLaplacianProduct.lean — solution of BookProof.ChapterLaplacianProduct.laplacian_radial_mul_harmonic
import Mathlib
import Definitions.Def_ChapterLaplacianProduct
import Theorems.Thm_BookProof_ChapterLaplacianProduct_laplacian_mul
import Theorems.Thm_BookProof_ChapterLaplacianProduct_fderiv_radial
import Theorems.Thm_BookProof_ChapterLaplacianProduct_sum_inner_mul_apply
open BookProof.ChapterLaplacianProduct




open Filter Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℝ E] {g : ℝ → ℝ} {H : E → ℝ} {x : E}
    {l : ℕ} (hx : x ≠ 0) (hg : ContDiffAt ℝ 2 g ‖x‖) (hH : ContDiffAt ℝ 2 H x)
    (hharm : (Δ H) x = 0) (heuler : fderiv ℝ H x x = l * H x) :
    (Δ fun y : E => g ‖y‖ * H y) x
      = (deriv (deriv g) ‖x‖
          + (((Module.finrank ℝ E : ℝ) - 1 + 2 * l) / ‖x‖) * deriv g ‖x‖) * H x := by

  have hr : 0 < ‖x‖ := norm_pos_iff.mpr hx
  have hr' : ‖x‖ ≠ 0 := ne_of_gt hr
  have hf : ContDiffAt ℝ 2 (fun y : E => g ‖y‖) x := by
    have hnorm : ContDiffAt ℝ 2 (fun y : E => ‖y‖) x := contDiffAt_norm ℝ hx
    exact hg.comp x hnorm
  have hprod := laplacian_mul hf hH
  -- the cross term
  have hcross : ∑ i, fderiv ℝ (fun y : E => g ‖y‖) x ((stdOrthonormalBasis ℝ E) i)
      * fderiv ℝ H x ((stdOrthonormalBasis ℝ E) i)
      = (deriv g ‖x‖ / ‖x‖) * ((l : ℝ) * H x) := by
    have hsum : ∑ i, (deriv g ‖x‖ / ‖x‖) * (⟪x, (stdOrthonormalBasis ℝ E) i⟫
        * fderiv ℝ H x ((stdOrthonormalBasis ℝ E) i))
        = (deriv g ‖x‖ / ‖x‖) * fderiv ℝ H x x := by
      rw [← Finset.mul_sum, sum_inner_mul_apply (fderiv ℝ H x) x]
    rw [← heuler, ← hsum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [fderiv_radial hx hg]
    simp [mul_assoc]
  rw [hprod, hcross, hharm, laplacian_radial hx hg]
  field_simp
  ring
