-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.finrank_WTwo
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_w2R_linearIndependent
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
theorem solution : finrank ℝ WTwo = 2 := by

  have h := finrank_span_eq_card w2R_linearIndependent
  rw [WTwo]
  exact h.trans (by simp)
