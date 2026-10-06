-- Generated from ChapterNoBestPrior.lean — theorem BookProof.ChapterNoBestPrior.not_uniformly_better
import Mathlib
import Definitions.Def_ChapterNoBestPrior
open BookProof.ChapterNoBestPrior

variable {Hyp : Type*} [Fintype Hyp]


open scoped BigOperators



theorem BookProof.ChapterNoBestPrior.not_uniformly_better (p q : Hyp → ℝ) (hpq : p ≠ q) :
    ¬ ∀ u : Hyp → ℝ, expectedUtility q u ≤ expectedUtility p u := by sorry
