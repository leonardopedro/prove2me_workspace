-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.eventProj_compl
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterConservativeDiagonal
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal
open BookProof.ConservativeDiagonal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (A : Set X) :
    BookProof.ChapterG3.eventProj Aᶜ = 1 - BookProof.ChapterG3.eventProj A := by

  funext x; by_cases h : x ∈ A <;>
    simp [BookProof.ChapterG3.eventProj, Set.indicator, Pi.sub_apply, h]
