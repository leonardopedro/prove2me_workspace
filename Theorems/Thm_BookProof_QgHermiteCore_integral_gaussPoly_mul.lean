-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.integral_gaussPoly_mul
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

theorem BookProof.QgHermiteCore.integral_gaussPoly_mul (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x * gaussPoly q x = gint (p * q) := by sorry
