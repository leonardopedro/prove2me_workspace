-- Generated from ChapterDeepLearningSampling.lean — theorem BookProof.ChapterDeepLearningSampling.sum_inducedPrior_event
import Mathlib
import Definitions.Def_ChapterDeepLearningSampling
open BookProof.ChapterDeepLearningSampling

variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]


open scoped BigOperators



theorem BookProof.ChapterDeepLearningSampling.sum_inducedPrior_event
    (seedProb : Seed → ℝ) (train : Seed → Model)
    (A : Finset Model) :
    ∑ m ∈ A, inducedPrior seedProb train m = ∑ s with train s ∈ A, seedProb s := by sorry
