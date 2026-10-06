-- Generated from ChapterLorentzRealRep.lean — theorem BookProof.ChapterLorentzRealRep.linIndep_of_gram
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

theorem BookProof.ChapterLorentzRealRep.linIndep_of_gram {n : ℕ} (v : Fin n → Matrix (Fin 4) (Fin 4) ℝ)
    (h : ∀ i j, ((v i)ᵀ * v j).trace = if i = j then (4 : ℝ) else 0) :
    LinearIndependent ℝ v := by sorry
