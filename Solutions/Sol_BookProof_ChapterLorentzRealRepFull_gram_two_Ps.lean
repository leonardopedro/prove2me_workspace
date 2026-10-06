-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.gram_two_Ps
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (i : Fin 2) (j : Fin 4), ((w2 i)ᵀ * bPs j).trace = 0 := by
 decide
