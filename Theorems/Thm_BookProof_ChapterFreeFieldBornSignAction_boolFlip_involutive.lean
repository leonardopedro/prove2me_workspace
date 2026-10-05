-- Generated from ChapterFreeFieldBornSignAction.lean — theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_involutive
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignAction

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge



theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_involutive (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    boolFlip b (boolFlip b x) = x := by sorry
