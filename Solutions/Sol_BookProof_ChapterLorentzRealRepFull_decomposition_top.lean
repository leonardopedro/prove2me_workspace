-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.decomposition_top
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_finrank_matrix
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_finrank_full
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : WHalf ⊔ W10 ⊔ WPs ⊔ WTwo = ⊤ := by

  apply Submodule.eq_top_of_finrank_eq
  rw [finrank_full, finrank_matrix]
