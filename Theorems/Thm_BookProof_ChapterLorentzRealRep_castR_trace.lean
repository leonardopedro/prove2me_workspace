-- Generated from ChapterLorentzRealRep.lean — theorem BookProof.ChapterLorentzRealRep.castR_trace
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep


open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

theorem BookProof.ChapterLorentzRealRep.castR_trace (A : Matrix (Fin 4) (Fin 4) ℤ) : (castR A).trace = ((A.trace : ℤ) : ℝ) := by sorry
