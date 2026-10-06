-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.mass_shell
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
import Theorems.Thm_BookProof_ChapterLorentzTranslation_gamma_sq
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (w : Fin 3 → ℝ) : gamma w ^ 2 - ∑ i, (w i) ^ 2 = 1 := by

  rw [gamma_sq]; ring
