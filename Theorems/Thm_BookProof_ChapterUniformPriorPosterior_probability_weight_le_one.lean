-- Generated from ChapterUniformPriorPosterior.lean — theorem BookProof.ChapterUniformPriorPosterior.probability_weight_le_one
import Mathlib
import Definitions.Def_ChapterUniformPriorPosterior
open BookProof.ChapterUniformPriorPosterior


open scoped BigOperators


variable {Hyp : Type*} [Fintype Hyp] [DecidableEq Hyp]


theorem BookProof.ChapterUniformPriorPosterior.probability_weight_le_one (q : Hyp → ℝ) (hq_nonneg : ∀ x, 0 ≤ q x)
    (hq_sum : ∑ x, q x = 1) (x : Hyp) : q x ≤ 1 := by sorry
