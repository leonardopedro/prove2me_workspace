-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.finrank_full_eq_add
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_finrank_WTwo
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_finrank_matrix
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution :
    finrank ℝ (Matrix (Fin 4) (Fin 4) ℝ)
      = finrank ℝ WHalf + finrank ℝ W10 + finrank ℝ WPs + finrank ℝ WTwo := by

  rw [finrank_matrix, finrank_WHalf, finrank_W10, finrank_WPs, finrank_WTwo]
