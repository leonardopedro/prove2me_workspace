-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.decomposition_top
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_finrank_matrix
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_finrank_full
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
theorem solution : WHalf ⊔ W10 ⊔ WPs ⊔ WTwo = ⊤ := by

  apply Submodule.eq_top_of_finrank_eq
  rw [finrank_full, BookProof.ChapterLorentzRealRepFull.finrank_matrix]
