-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.deriv_gaussPoly
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.deriv_gaussPoly (p : Polynomial ℝ) :
    deriv (gaussPoly p) = gaussPoly (gaussPolyDeriv p) := by sorry
