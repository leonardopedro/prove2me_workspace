-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.gram_two
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ i j : Fin 2, ((w2 i)ᵀ * w2 j).trace = if i = j then 4 else 0 := by
 decide
