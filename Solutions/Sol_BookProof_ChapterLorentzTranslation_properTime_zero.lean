-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.properTime_zero
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (w : Fin 3 → ℝ) : properTime w 0 (0 : Fin 3 → ℝ) = 0 := by

  unfold properTime; simp
