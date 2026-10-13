-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.gram_all
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ i j : Fin 14, ((bAll i)ᵀ * bAll j).trace = if i = j then 4 else 0 := by

  decide
