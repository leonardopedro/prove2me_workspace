-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.jointProb_eq_normSq_weakNumerator
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_ip_projMat
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U V : Matrix (Fin n) (Fin n) ℂ)
    (psi : Fin n → ℂ) (f a : Fin n) :
    ‖ip (postSelect V f) (projMat a *ᵥ (U *ᵥ psi))‖ ^ 2 = jointProb U V psi f a := by

  rw [ip_projMat, jointProb, midProb, transProb]
  simp [postSelect, mul_pow]
  ring
