-- Generated from ChapterLorentzRealRepSum.lean — theorem BookProof.ChapterLorentzRealRepSum.gram_allR
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

theorem BookProof.ChapterLorentzRealRepSum.gram_allR :
    ∀ i j : Fin 14, ((bAllR i)ᵀ * bAllR j).trace = if i = j then (4 : ℝ) else 0 := by sorry
