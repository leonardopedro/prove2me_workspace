-- Generated from ChapterLorentzRealRep.lean — theorem BookProof.ChapterLorentzRealRep.gram_halfR
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

theorem BookProof.ChapterLorentzRealRep.gram_halfR :
    ∀ i j : Fin 4, ((bHalfR i)ᵀ * bHalfR j).trace = if i = j then (4 : ℝ) else 0 := by sorry
