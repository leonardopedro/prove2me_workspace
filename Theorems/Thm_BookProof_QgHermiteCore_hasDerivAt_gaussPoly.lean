-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.hasDerivAt_gaussPoly
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.hasDerivAt_gaussPoly (p : Polynomial ℝ) (x : ℝ) :
    HasDerivAt (gaussPoly p) (gaussPoly (gaussPolyDeriv p) x) x := by sorry
