-- Generated from ChapterDeepLearningSampling.lean — theorem BookProof.ChapterDeepLearningSampling.posterior_eq_zero_of_not_mem_range
import Mathlib
import Definitions.Def_ChapterDeepLearningSampling
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterDeepLearningSampling


open scoped BigOperators


variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]








variable [Fintype Model]


theorem BookProof.ChapterDeepLearningSampling.posterior_eq_zero_of_not_mem_range (seedProb : Seed → ℝ)
    (train : Seed → Model) (likelihood : Model → Data → ℝ) (d : Data)
    {m : Model} (hm : m ∉ Set.range train) :
    posterior seedProb train likelihood d m = 0 := by sorry
