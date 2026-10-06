-- Generated from ChapterLorentzRealRepFull.lean — theorem BookProof.ChapterLorentzRealRepFull.gram_two
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRep
import Definitions.Def_ChapterLorentzRealRepSum
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
open BookProof.ChapterLorentzRealRepFull


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

theorem BookProof.ChapterLorentzRealRepFull.gram_two : ∀ i j : Fin 2, ((w2 i)ᵀ * w2 j).trace = if i = j then 4 else 0 := by sorry
