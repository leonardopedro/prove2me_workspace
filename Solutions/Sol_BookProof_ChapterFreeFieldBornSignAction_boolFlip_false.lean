-- Generated from ChapterFreeFieldBornSignAction.lean — solution of BookProof.ChapterFreeFieldBornSignAction.boolFlip_false
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignAction



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : EuclideanSpace ℝ (Fin n)) :
    boolFlip (fun _ => false) x = x := by

  ext k; exact (by
  convert boolFlip_apply ( fun _ => false ) x k using 1 ; norm_num)
