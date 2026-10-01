-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.gint_gaussPolyDeriv_two_symm
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

theorem BookProof.QgHermiteCore.gint_gaussPolyDeriv_two_symm (p q : Polynomial ℝ) :
    gint (gaussPolyDeriv (gaussPolyDeriv p) * q)
      = gint (p * gaussPolyDeriv (gaussPolyDeriv q)) := by sorry
