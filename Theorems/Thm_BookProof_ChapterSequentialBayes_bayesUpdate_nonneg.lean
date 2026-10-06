-- Generated from ChapterSequentialBayes.lean — theorem BookProof.ChapterSequentialBayes.bayesUpdate_nonneg
import Mathlib
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterSequentialBayes

variable {X : Type*} [Fintype X]


open scoped BigOperators



theorem BookProof.ChapterSequentialBayes.bayesUpdate_nonneg {prior ℓ : X → ℝ} (hprior : ∀ x, 0 ≤ prior x)
    (hℓ : ∀ x, 0 ≤ ℓ x) (x : X) : 0 ≤ bayesUpdate prior ℓ x := by sorry
