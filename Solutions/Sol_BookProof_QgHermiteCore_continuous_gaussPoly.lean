-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.continuous_gaussPoly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterHermiteFunctions
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (p : Polynomial ℝ) : Continuous (gaussPoly p) := p.continuous_aeval.mul continuous_gaussH
