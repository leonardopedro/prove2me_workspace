-- Generated from ChapterNoBestPrior.lean — theorem BookProof.ChapterNoBestPrior.distinct_priors_each_preferred
import Mathlib
import Definitions.Def_ChapterNoBestPrior
open BookProof.ChapterNoBestPrior


open scoped BigOperators


variable {Hyp : Type*} [Fintype Hyp]


theorem BookProof.ChapterNoBestPrior.distinct_priors_each_preferred (p q : Hyp → ℝ) (hpq : p ≠ q) :
    (∃ u, expectedUtility q u < expectedUtility p u) ∧
      ∃ v, expectedUtility p v < expectedUtility q v := by sorry
