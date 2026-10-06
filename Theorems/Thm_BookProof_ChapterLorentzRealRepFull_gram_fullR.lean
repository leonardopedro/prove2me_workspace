-- Generated from ChapterLorentzRealRepFull.lean — theorem BookProof.ChapterLorentzRealRepFull.gram_fullR
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

theorem BookProof.ChapterLorentzRealRepFull.gram_fullR :
    ∀ i j : Fin 16, ((bFullR i)ᵀ * bFullR j).trace = if i = j then (4 : ℝ) else 0 := by sorry
