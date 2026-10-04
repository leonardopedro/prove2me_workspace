-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.eventProj_union
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterConservativeDiagonal
import Definitions.Def_ChapterA4
open BookProof.ConservativeDiagonal
open BookProof.ChapterG3

variable {X : Type*}


open MeasureTheory
open scoped ENNReal




theorem BookProof.ChapterG3.eventProj_union (A B : Set X) :
    eventProj (A ∪ B) = eventProj A + eventProj B - eventProj A * eventProj B := by sorry
