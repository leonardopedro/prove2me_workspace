-- Generated from ChapterSequentialBayes.lean — theorem BookProof.ChapterSequentialBayes.bayesUpdate_evidence
import Mathlib
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterSequentialBayes


open scoped BigOperators


variable {X : Type*} [Fintype X]


theorem BookProof.ChapterSequentialBayes.bayesUpdate_evidence {prior ℓ₁ ℓ₂ : X → ℝ} :
    (∑ x, bayesUpdate prior ℓ₁ x * ℓ₂ x)
      = (∑ x, prior x * (ℓ₁ x * ℓ₂ x)) / (∑ x, prior x * ℓ₁ x) := by sorry
