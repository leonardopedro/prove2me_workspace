-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.finrank_full
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_bFullR_linearIndependent
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_span_bFullR_eq
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : finrank ℝ ↥(WHalf ⊔ W10 ⊔ WPs ⊔ WTwo) = 16 := by

  have := finrank_span_eq_card bFullR_linearIndependent
  rw [span_bFullR_eq] at this
  simpa using this
