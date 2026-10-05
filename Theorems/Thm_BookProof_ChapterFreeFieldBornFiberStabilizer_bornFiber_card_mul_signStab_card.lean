-- Generated from ChapterFreeFieldBornFiberStabilizer.lean — theorem BookProof.ChapterFreeFieldBornFiberStabilizer.bornFiber_card_mul_signStab_card
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornQuotient
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Definitions.Def_ChapterFreeFieldBornFiberCardGeneral
import Definitions.Def_ChapterFreeFieldBornFiberBounds
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberStabilizer
open BookProof.ChapterFreeFieldBornFiberStabilizer

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberBounds



theorem BookProof.ChapterFreeFieldBornFiberStabilizer.bornFiber_card_mul_signStab_card
    (x : ↥(Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1)) :
    Nat.card ↥(bornMapSphere n ⁻¹' {bornMapSphere n x}) *
        (signStab (x : EuclideanSpace ℝ (Fin n))).card = 2 ^ n := by sorry
