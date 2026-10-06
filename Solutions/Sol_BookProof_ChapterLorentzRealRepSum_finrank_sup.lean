-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.finrank_sup
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_bAllR_linearIndependent
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_span_bAllR_eq
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution : finrank ℝ ↥(WHalf ⊔ W10 ⊔ WPs) = 14 := by

  have := finrank_span_eq_card bAllR_linearIndependent
  rw [span_bAllR_eq] at this
  simpa using this
