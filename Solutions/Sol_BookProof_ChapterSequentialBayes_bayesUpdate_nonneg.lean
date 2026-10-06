-- Generated from ChapterSequentialBayes.lean — solution of BookProof.ChapterSequentialBayes.bayesUpdate_nonneg
import Mathlib
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterSequentialBayes



open scoped BigOperators


variable {X : Type*} [Fintype X]

variable {X : Type*} [Fintype X]

set_option maxHeartbeats 1000000 in
theorem solution {prior ℓ : X → ℝ} (hprior : ∀ x, 0 ≤ prior x)
    (hℓ : ∀ x, 0 ≤ ℓ x) (x : X) : 0 ≤ bayesUpdate prior ℓ x := by

  unfold bayesUpdate
  apply div_nonneg (mul_nonneg (hprior x) (hℓ x))
  exact Finset.sum_nonneg fun i _ => mul_nonneg (hprior i) (hℓ i)
