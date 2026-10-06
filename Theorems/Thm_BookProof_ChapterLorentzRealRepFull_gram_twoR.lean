-- Generated from ChapterLorentzRealRepFull.lean — theorem BookProof.ChapterLorentzRealRepFull.gram_twoR
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRepSum
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepFull


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

theorem BookProof.ChapterLorentzRealRepFull.gram_twoR : ∀ i j : Fin 2, ((w2R i)ᵀ * w2R j).trace = if i = j then (4 : ℝ) else 0 := by sorry
