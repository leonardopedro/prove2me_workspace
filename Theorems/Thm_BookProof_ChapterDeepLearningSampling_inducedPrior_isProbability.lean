-- Generated from ChapterDeepLearningSampling.lean — theorem BookProof.ChapterDeepLearningSampling.inducedPrior_isProbability
import Mathlib
import Definitions.Def_ChapterDeepLearningSampling
open BookProof.ChapterDeepLearningSampling


open scoped BigOperators


variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]


theorem BookProof.ChapterDeepLearningSampling.inducedPrior_isProbability [Fintype Model]
    (seedProb : Seed → ℝ) (train : Seed → Model)
    (hnonneg : ∀ s, 0 ≤ seedProb s) (hsum : ∑ s, seedProb s = 1) :
    (∀ m, 0 ≤ inducedPrior seedProb train m) ∧
      ∑ m, inducedPrior seedProb train m = 1 := by sorry
