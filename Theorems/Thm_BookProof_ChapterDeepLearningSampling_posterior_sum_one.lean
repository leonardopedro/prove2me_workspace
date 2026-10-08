-- Generated from ChapterDeepLearningSampling.lean — theorem BookProof.ChapterDeepLearningSampling.posterior_sum_one
import Mathlib
import Definitions.Def_ChapterDeepLearningSampling
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterDeepLearningSampling


open scoped BigOperators


variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]








variable [Fintype Model]


theorem BookProof.ChapterDeepLearningSampling.posterior_sum_one (seedProb : Seed → ℝ) (train : Seed → Model)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hd : 0 < evidence seedProb train likelihood d) :
    ∑ m, posterior seedProb train likelihood d m = 1 := by sorry
