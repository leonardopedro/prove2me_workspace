-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.properTime_rest
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
import Theorems.Thm_BookProof_ChapterLorentzTranslation_gamma_zero
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (x0 : ℝ) (xs : Fin 3 → ℝ) :
    properTime (fun _ => 0) x0 xs = x0 := by

  unfold properTime; simp [gamma_zero]
