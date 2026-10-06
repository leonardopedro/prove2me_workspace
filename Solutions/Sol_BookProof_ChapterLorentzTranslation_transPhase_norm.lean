-- Generated from ChapterLorentzTranslation.lean — solution of BookProof.ChapterLorentzTranslation.transPhase_norm
import Mathlib
import Definitions.Def_ChapterLorentzTranslation
open BookProof.ChapterLorentzTranslation




open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : ℝ) (w : Fin 3 → ℝ) (x0 : ℝ) (xs : Fin 3 → ℝ) :
    ‖transPhase M w x0 xs‖ = 1 := by

  unfold transPhase
  rw [Complex.norm_exp]
  have : (Complex.I * (M : ℂ) * (properTime w x0 xs : ℂ)).re = 0 := by
    simp [Complex.mul_re, Complex.mul_im]
  rw [this, Real.exp_zero]
