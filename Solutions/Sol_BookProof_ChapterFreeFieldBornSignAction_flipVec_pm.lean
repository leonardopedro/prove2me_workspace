-- Generated from ChapterFreeFieldBornSignAction.lean — solution of BookProof.ChapterFreeFieldBornSignAction.flipVec_pm
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignAction
open BookProof.ChapterFreeFieldBornSignAction



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) (k : Fin n) :
    flipVec b k = 1 ∨ flipVec b k = -1 := by

  unfold flipVec; split_ifs <;> simp
