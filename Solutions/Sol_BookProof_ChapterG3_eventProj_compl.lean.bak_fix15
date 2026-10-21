-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.eventProj_compl
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (A : Set X) :
    eventProj Aᶜ = 1 - eventProj A := by

  funext x; by_cases h : x ∈ A <;>
    simp [eventProj, Set.indicator, Pi.sub_apply, h]
