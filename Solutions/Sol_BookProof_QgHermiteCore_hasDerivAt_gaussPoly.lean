-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.hasDerivAt_gaussPoly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) (x : ℝ) :
    HasDerivAt (gaussPoly p) (gaussPoly (gaussPolyDeriv p) x) x := by

  have hp : HasDerivAt (fun y : ℝ => p.eval y) ((Polynomial.derivative p).eval x) x :=
    p.hasDerivAt x
  have hg := hasDerivAt_gaussH x
  refine (hp.mul hg).congr_deriv ?_
  simp only [gaussPoly, gaussPolyDeriv, Polynomial.eval_sub, Polynomial.eval_mul,
    Polynomial.eval_C, Polynomial.eval_X]
  ring
