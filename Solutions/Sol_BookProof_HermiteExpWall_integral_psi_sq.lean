-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.integral_psi_sq
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_gaussMoment_eq_integral
import Theorems.Thm_BookProof_HermiteExpWall_psi_sq
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) : ∫ x : ℝ, psi N x ^ 2 = gaussMoment (2 * N) := by

  rw [gaussMoment_eq_integral]
  exact integral_congr_ae (Filter.Eventually.of_forall fun x => psi_sq N x)
