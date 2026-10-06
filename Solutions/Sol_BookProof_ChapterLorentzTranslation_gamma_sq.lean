-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.gamma_sq
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (w : Fin 3 → ℝ) : gamma w ^ 2 = 1 + ∑ i, (w i) ^ 2 := by

  unfold gamma; rw [Real.sq_sqrt (by positivity)]
