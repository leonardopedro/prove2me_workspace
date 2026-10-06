-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.integral_gaussPoly_sq
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_QgHermiteCore_integral_gaussPoly_mul
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly q x ^ 2 = gint (q * q) :=
    rw [← integral_gaussPoly_mul q q]
    exact integral_congr_ae (Filter.Eventually.of_forall fun x => sq (gaussPoly q x))
  
  theo
