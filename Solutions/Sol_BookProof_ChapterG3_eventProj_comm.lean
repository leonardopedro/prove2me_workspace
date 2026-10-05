-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.eventProj_comm
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (A B : Set X) :
    eventProj A * eventProj B = eventProj B * eventProj A := by

  ring
