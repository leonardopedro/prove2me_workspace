-- Generated from ChapterFreeFieldBornFiberStabilizer.lean — theorem BookProof.ChapterFreeFieldBornFiberStabilizer.signStab_card
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



theorem BookProof.ChapterFreeFieldBornFiberStabilizer.signStab_card (x : EuclideanSpace ℝ (Fin n)) :
    (signStab x).card = 2 ^ (Finset.univ.filter (fun k => x k = 0)).card := by sorry
