-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.continuous_gaussPoly
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.continuous_gaussPoly (p : Polynomial ℝ) : Continuous (gaussPoly p) := by sorry
