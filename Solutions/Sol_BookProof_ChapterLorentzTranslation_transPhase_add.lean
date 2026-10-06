-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.transPhase_add
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
import Theorems.Thm_BookProof_ChapterLorentzTranslation_properTime_add
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) (w : Fin 3 → ℝ) (x0 y0 : ℝ) (xs ys : Fin 3 → ℝ) :
    transPhase M w (x0 + y0) (xs + ys) = transPhase M w x0 xs * transPhase M w y0 ys := by

  unfold transPhase
  rw [properTime_add, ← Complex.exp_add]
  congr 1
  push_cast
  ring
