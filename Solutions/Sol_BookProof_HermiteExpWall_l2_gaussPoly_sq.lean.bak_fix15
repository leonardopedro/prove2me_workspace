-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.l2_gaussPoly_sq
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_integral_gaussPoly_sq
import Theorems.Thm_BookProof_HermiteExpWall_gint_self_nonneg
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (q : Polynomial ℝ) : l2 (gaussPoly q) ^ 2 = gint (q * q) :=
    rw [l2, Real.sq_sqrt (by rw [integral_gaussPoly_sq]; exact gint_self_nonneg q)]
    exact integral_gaussPoly_sq q
  
  /--
