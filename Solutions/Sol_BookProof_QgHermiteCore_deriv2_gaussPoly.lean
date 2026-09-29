-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.deriv2_gaussPoly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_deriv_gaussPoly
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) :
    deriv (deriv (gaussPoly p)) = gaussPoly (gaussPolyDeriv (gaussPolyDeriv p)) := by

  rw [deriv_gaussPoly, deriv_gaussPoly]
