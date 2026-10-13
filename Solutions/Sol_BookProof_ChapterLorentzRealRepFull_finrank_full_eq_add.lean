-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.finrank_full_eq_add
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_finrank_WTwo
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_finrank_matrix
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_finrank_W10
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_finrank_WHalf
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_finrank_WPs
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterPinOmega
import Definitions.Def_ChapterLorentzRealRepSum
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module
open BookProof.ChapterLorentzRealRep

set_option maxHeartbeats 1000000 in
theorem solution :
    finrank ℝ (Matrix (Fin 4) (Fin 4) ℝ)
      = finrank ℝ WHalf + finrank ℝ W10 + finrank ℝ WPs + finrank ℝ WTwo := by

  rw [BookProof.ChapterLorentzRealRepFull.finrank_matrix, finrank_WHalf, finrank_W10, finrank_WPs, finrank_WTwo]
