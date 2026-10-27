-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.eventProj_inter
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (A B : Set X) :
    eventProj (A ∩ B) = eventProj A * eventProj B := by

  funext x; by_cases hA : x ∈ A <;> by_cases hB : x ∈ B <;>
    simp [eventProj, Set.indicator, hA, hB]
