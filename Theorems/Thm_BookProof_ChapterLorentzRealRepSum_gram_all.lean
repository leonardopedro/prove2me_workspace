-- Generated from ChapterLorentzRealRepSum.lean — theorem BookProof.ChapterLorentzRealRepSum.gram_all
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRep
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepSum


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

theorem BookProof.ChapterLorentzRealRepSum.gram_all : ∀ i j : Fin 14, ((bAll i)ᵀ * bAll j).trace = if i = j then 4 else 0 := by sorry
