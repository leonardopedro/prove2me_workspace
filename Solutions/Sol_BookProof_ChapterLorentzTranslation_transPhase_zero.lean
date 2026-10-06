-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.transPhase_zero
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
import Theorems.Thm_BookProof_ChapterLorentzTranslation_properTime_zero
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) (w : Fin 3 → ℝ) :
    transPhase M w 0 (0 : Fin 3 → ℝ) = 1 := by

  unfold transPhase; rw [properTime_zero]; simp
