-- Generated from ChapterSequentialBayes.lean — theorem BookProof.ChapterSequentialBayes.bayesUpdate_sum_one
import Mathlib
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterSequentialBayes


open scoped BigOperators


variable {X : Type*} [Fintype X]


theorem BookProof.ChapterSequentialBayes.bayesUpdate_sum_one {prior ℓ : X → ℝ} (hpos : 0 < totEvidence prior ℓ) :
    ∑ x, bayesUpdate prior ℓ x = 1 := by sorry
