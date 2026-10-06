-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.finrank_sup_eq_add
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_finrank_WHalf
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_finrank_W10
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_finrank_WPs
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_finrank_sup
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution :
    finrank ℝ ↥(WHalf ⊔ W10 ⊔ WPs) = finrank ℝ WHalf + finrank ℝ W10 + finrank ℝ WPs := by

  rw [finrank_sup, finrank_WHalf, finrank_W10, finrank_WPs]
