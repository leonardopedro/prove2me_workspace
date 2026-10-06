-- Generated from ChapterNoBestPrior.lean — theorem BookProof.ChapterNoBestPrior.eq_of_expectedUtility_ge_all
import Mathlib
import Definitions.Def_ChapterNoBestPrior
open BookProof.ChapterNoBestPrior

variable {Hyp : Type*} [Fintype Hyp]


open scoped BigOperators



theorem BookProof.ChapterNoBestPrior.eq_of_expectedUtility_ge_all (p q : Hyp → ℝ)
    (h : ∀ u : Hyp → ℝ, expectedUtility q u ≤ expectedUtility p u) :
    p = q := by sorry
