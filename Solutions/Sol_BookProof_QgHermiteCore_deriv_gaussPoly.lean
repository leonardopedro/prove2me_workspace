-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.deriv_gaussPoly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_hasDerivAt_gaussPoly
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) :
    deriv (gaussPoly p) = gaussPoly (gaussPolyDeriv p) := by

  funext x
  exact (hasDerivAt_gaussPoly p x).deriv
