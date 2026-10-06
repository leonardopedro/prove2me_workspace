-- Generated from ChapterWeakValue.lean — solution of BookProof.ChapterWeakValue.condProb_eq_weakNumerator_ratio
import Mathlib
import Definitions.Def_ChapterWeakValue
import Theorems.Thm_BookProof_ChapterWeakValue_jointProb_eq_normSq_weakNumerator
open BookProof.ChapterWeakValue



open scoped BigOperators Matrix


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U V : Matrix (Fin n) (Fin n) ℂ)
    (psi : Fin n → ℂ) (f a : Fin n) :
    condProb U V psi f a =
      ‖ip (postSelect V f) (projMat a *ᵥ (U *ᵥ psi))‖ ^ 2 /
        ∑ b, ‖ip (postSelect V f) (projMat b *ᵥ (U *ᵥ psi))‖ ^ 2 := by

  rw [condProb, finalProb, jointProb_eq_normSq_weakNumerator]
  exact congrArg _
    (Finset.sum_congr rfl fun b _ =>
      (jointProb_eq_normSq_weakNumerator U V psi f b).symm)
