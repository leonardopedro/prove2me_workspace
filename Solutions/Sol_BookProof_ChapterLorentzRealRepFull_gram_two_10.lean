-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.gram_two_10
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (i : Fin 2) (j : Fin 6), ((w2 i)ᵀ * b10 j).trace = 0 := by
 decide
