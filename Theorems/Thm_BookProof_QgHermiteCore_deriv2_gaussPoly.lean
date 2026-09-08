-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.deriv2_gaussPoly
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

theorem BookProof.QgHermiteCore.deriv2_gaussPoly (p : Polynomial ℝ) :
    deriv (deriv (gaussPoly p)) = gaussPoly (gaussPolyDeriv (gaussPolyDeriv p)) := by sorry
