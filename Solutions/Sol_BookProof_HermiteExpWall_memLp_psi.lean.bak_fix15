-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.memLp_psi
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_psi_sq
import Theorems.Thm_BookProof_QgHermiteCore_continuous_gaussPoly
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) : MemLp (psi N) 2 volume := by

  refine (memLp_two_iff_integrable_sq_norm
    ((continuous_gaussPoly _).aestronglyMeasurable)).mpr ?_
  have h := integrable_poly_mul_gaussW ((Polynomial.X : Polynomial ℝ) ^ (2 * N))
  refine h.congr (Filter.Eventually.of_forall fun x => ?_)
  simp only [Real.norm_eq_abs, sq_abs]
  rw [show gaussPoly ((Polynomial.X : Polynomial ℝ) ^ N) x = psi N x from rfl, psi_sq]
  simp
