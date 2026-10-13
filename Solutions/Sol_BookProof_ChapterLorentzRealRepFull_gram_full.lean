-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.gram_full
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRep
import Definitions.Def_ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ i j : Fin 16, ((bFull i)ᵀ * bFull j).trace = if i = j then 4 else 0 := by

  decide
