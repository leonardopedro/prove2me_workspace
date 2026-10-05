-- Generated from ChapterFreeFieldBornSignAction.lean — solution of BookProof.ChapterFreeFieldBornSignAction.bornMap_boolFlip
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignAction_flipVec_pm
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignGauge_bornMap_signFlip
open BookProof.ChapterFreeFieldBornSignAction



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    bornMap (boolFlip b x) = bornMap x := bornMap_signFlip (flipVec_pm b) x
