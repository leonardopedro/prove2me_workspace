-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.gram_half10
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (i : Fin 4) (j : Fin 6), ((bHalf i)ᵀ * b10 j).trace = 0 := by
 decide
