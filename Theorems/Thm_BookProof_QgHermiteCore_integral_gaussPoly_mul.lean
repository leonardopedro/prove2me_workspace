-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.integral_gaussPoly_mul
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

theorem BookProof.QgHermiteCore.integral_gaussPoly_mul (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x * gaussPoly q x = gint (p * q) := by sorry
