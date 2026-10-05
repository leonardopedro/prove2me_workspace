-- Generated from ChapterFreeFieldBornFiberStabilizer.lean — solution of BookProof.ChapterFreeFieldBornFiberStabilizer.boolSign_pm
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberStabilizer
open BookProof.ChapterFreeFieldBornFiberStabilizer



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberBounds


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) (k : Fin n) :
    boolSign b k = 1 ∨ boolSign b k = -1 := by

  unfold boolSign; split_ifs <;> simp
