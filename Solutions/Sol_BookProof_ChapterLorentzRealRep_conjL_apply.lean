-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.conjL_apply
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution (S T A : Matrix (Fin 4) (Fin 4) ℝ) : conjL S T A = S * A * T := by

  simp [conjL, mul_assoc]
