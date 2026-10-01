-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.expBounded_scalaronSectorPotential
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.HermiteProductCore
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.Starobinsky
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.expBounded_scalaronSectorPotential (M alpha : ℝ) (hM : 0 < M) (V3 : Polynomial ℝ) :
    ExpBounded (scalaronSectorPotential M alpha V3) := by sorry
