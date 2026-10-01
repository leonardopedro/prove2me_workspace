-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.continuous_scalaronSectorPotential
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.HermiteProductCore
open BookProof.Starobinsky
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.continuous_scalaronSectorPotential (M alpha : ℝ) (V3 : Polynomial ℝ) :
    Continuous (scalaronSectorPotential M alpha V3) := by sorry
