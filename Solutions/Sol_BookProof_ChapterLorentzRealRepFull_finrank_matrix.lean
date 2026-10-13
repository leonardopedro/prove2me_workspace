-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.finrank_matrix
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRep
import Definitions.Def_ChapterLorentzRealRepSum
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : finrank ℝ (Matrix (Fin 4) (Fin 4) ℝ) = 16 := by

  simp [Module.finrank_matrix]
