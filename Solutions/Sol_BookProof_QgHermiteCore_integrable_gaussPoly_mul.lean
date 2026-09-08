-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.integrable_gaussPoly_mul
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p q : Polynomial ℝ) :
    Integrable (fun x : ℝ => gaussPoly p x * gaussPoly q x) := by

  refine (integrable_poly_mul_gaussW (p * q)).congr (Filter.Eventually.of_forall fun x => ?_)
  have h := gaussH_sq x
  simp only [gaussPoly, Polynomial.eval_mul]
  rw [← h]
  ring
