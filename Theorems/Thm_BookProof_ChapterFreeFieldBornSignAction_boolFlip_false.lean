-- Generated from ChapterFreeFieldBornSignAction.lean — theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_false
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignAction

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge



theorem BookProof.ChapterFreeFieldBornSignAction.boolFlip_false (x : EuclideanSpace ℝ (Fin n)) :
    boolFlip (fun _ => false) x = x := by sorry
