-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.gram_10Ps
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
theorem solution : ∀ (i : Fin 6) (j : Fin 4), ((b10 i)ᵀ * bPs j).trace = 0 := by
 decide
