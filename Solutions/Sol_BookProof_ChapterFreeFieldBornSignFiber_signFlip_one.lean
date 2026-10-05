-- Generated from ChapterFreeFieldBornSignFiber.lean — solution of BookProof.ChapterFreeFieldBornSignFiber.signFlip_one
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignFiber
open BookProof.ChapterFreeFieldBornSignFiber



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : EuclideanSpace ℝ (Fin n)) :
    signFlip (fun _ => 1) x = x := by

  ext k; simp [signFlip]
