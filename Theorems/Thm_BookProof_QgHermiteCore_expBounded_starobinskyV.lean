-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.expBounded_starobinskyV
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.expBounded_starobinskyV (M alpha : ℝ) (hM : 0 < M) :
    ExpBounded (starobinskyV M alpha) := by sorry
