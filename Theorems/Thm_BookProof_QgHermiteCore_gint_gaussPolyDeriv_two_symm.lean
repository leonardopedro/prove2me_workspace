-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.gint_gaussPolyDeriv_two_symm
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore













open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

theorem BookProof.QgHermiteCore.gint_gaussPolyDeriv_two_symm (p q : Polynomial ℝ) :
    gint (gaussPolyDeriv (gaussPolyDeriv p) * q)
      = gint (p * gaussPolyDeriv (gaussPolyDeriv q)) := by sorry
