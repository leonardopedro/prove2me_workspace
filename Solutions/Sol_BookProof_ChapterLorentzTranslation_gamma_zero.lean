-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.gamma_zero
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : gamma (fun _ => 0) = 1 := by

  unfold gamma; simp
