-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.gint_gaussPolyDeriv_antisymm
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

theorem BookProof.QgHermiteCore.gint_gaussPolyDeriv_antisymm (p q : Polynomial ℝ) :
    gint (gaussPolyDeriv p * q) = - gint (p * gaussPolyDeriv q) := by sorry
