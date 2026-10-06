-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.transPhase_rest
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
import Theorems.Thm_BookProof_ChapterLorentzTranslation_properTime_rest
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) (x0 : ℝ) (xs : Fin 3 → ℝ) :
    transPhase M (fun _ => 0) x0 xs = Complex.exp (Complex.I * (M : ℂ) * (x0 : ℂ)) := by

  unfold transPhase; rw [properTime_rest]
