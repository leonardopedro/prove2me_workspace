-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.finrank_W10
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
import Theorems.Thm_BookProof_ChapterLorentzRealRep_b10R_linearIndependent
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution : finrank ℝ W10 = 6 := by

  have := finrank_span_eq_card b10R_linearIndependent
  first | exact this | (convert this using 1 <;> (first | rfl | simp [W10]))
