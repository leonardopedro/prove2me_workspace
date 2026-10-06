-- Generated from ChapterSequentialBayes.lean — solution of BookProof.ChapterSequentialBayes.bayesUpdate_evidence
import Mathlib
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterSequentialBayes



open scoped BigOperators


variable {X : Type*} [Fintype X]

variable {X : Type*} [Fintype X]

set_option maxHeartbeats 1000000 in
theorem solution {prior ℓ₁ ℓ₂ : X → ℝ} :
    (∑ x, bayesUpdate prior ℓ₁ x * ℓ₂ x)
      = (∑ x, prior x * (ℓ₁ x * ℓ₂ x)) / (∑ x, prior x * ℓ₁ x) := by

  unfold bayesUpdate
  rw [Finset.sum_div]
  exact Finset.sum_congr rfl (fun x _ => by ring)
