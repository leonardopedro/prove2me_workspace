-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.l2_psi_sq
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_gaussMoment_even_pos
import Theorems.Thm_BookProof_HermiteExpWall_integral_psi_sq
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) : l2 (psi N) ^ 2 = gaussMoment (2 * N) := by

  rw [l2, Real.sq_sqrt]
  · exact integral_psi_sq N
  · rw [integral_psi_sq N]; exact (gaussMoment_even_pos N).le
