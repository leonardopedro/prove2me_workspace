-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.integral_gaussPoly_mul
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x * gaussPoly q x = gint (p * q) := by

  rw [gint]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  have h := gaussH_sq x
  simp only [gaussPoly, Polynomial.eval_mul]
  rw [← h]
  ring
