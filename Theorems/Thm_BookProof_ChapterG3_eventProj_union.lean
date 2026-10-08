-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.eventProj_union
import Mathlib
import Definitions.Def_ChapterG3
import Definitions.Def_ChapterConservativeDiagonal
open BookProof.ConservativeDiagonal
open BookProof.ChapterG3


open MeasureTheory
open scoped ENNReal



variable {X : Type*}


theorem BookProof.ChapterG3.eventProj_union (A B : Set X) :
    eventProj (A ∪ B) = eventProj A + eventProj B - eventProj A * eventProj B := by sorry
