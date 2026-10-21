-- Generated from ChapterRadialLaplacian.lean — solution of BookProof.ChapterRadialLaplacian.laplacian_sbessel_zero
import Mathlib
import Definitions.Def_ChapterRadialLaplacian
import Theorems.Thm_BookProof_ChapterRadialLaplacian_laplacian_radial
import Theorems.Thm_BookProof_ChapterRadialLaplacian_contDiffAt_sbessel_zero
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_sbessel_radial_eigen
open BookProof.ChapterRadialLaplacian




open Filter Laplacian InnerProductSpace
open scoped InnerProductSpace RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℝ E] (h3 : Module.finrank ℝ E = 3)
    {p : ℝ} {x : E} (hp : p ≠ 0) (hx : x ≠ 0) :
    (Δ fun y : E => sbessel 0 (p * ‖y‖)) x = -(p ^ 2) * sbessel 0 (p * ‖x‖) := by

  have hr : 0 < ‖x‖ := norm_pos_iff.mpr hx
  have hr' : ‖x‖ ≠ 0 := ne_of_gt hr
  have hg : ContDiffAt ℝ 2 (fun s : ℝ => sbessel 0 (p * s)) ‖x‖ := by
    have hmul : ContDiffAt ℝ 2 (fun s : ℝ => p * s) ‖x‖ :=
      (contDiff_const.mul contDiff_id).contDiffAt
    exact (contDiffAt_sbessel_zero (mul_ne_zero hp hr')).comp ‖x‖ hmul
  have hlap := laplacian_radial (g := fun s : ℝ => sbessel 0 (p * s)) hx hg
  rw [h3] at hlap
  have heigen := sbessel_radial_eigen 0 hp hr'
  push_cast at hlap heigen ⊢
  rw [hlap]
  have h2 : deriv (deriv fun s : ℝ => sbessel 0 (p * s)) ‖x‖
      + (2 / ‖x‖) * deriv (fun s : ℝ => sbessel 0 (p * s)) ‖x‖
      = -(p ^ 2) * sbessel 0 (p * ‖x‖) := by
    simp only [zero_add, zero_mul, zero_div, sub_zero, neg_add_rev] at heigen
    linarith [heigen]
  rw [← h2]
  field_simp
  ring
