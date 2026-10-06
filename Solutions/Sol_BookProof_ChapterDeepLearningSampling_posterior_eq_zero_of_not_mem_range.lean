-- Generated from ChapterDeepLearningSampling.lean — solution of BookProof.ChapterDeepLearningSampling.posterior_eq_zero_of_not_mem_range
import Mathlib
import Definitions.Def_ChapterDeepLearningSampling
open BookProof.ChapterDeepLearningSampling



open scoped BigOperators


variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]








variable [Fintype Model]

variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]
variable [Fintype Model]

set_option maxHeartbeats 1000000 in
theorem solution (seedProb : Seed → ℝ)
    (train : Seed → Model) (likelihood : Model → Data → ℝ) (d : Data)
    {m : Model} (hm : m ∉ Set.range train) :
    posterior seedProb train likelihood d m = 0 := by

  unfold posterior;
  unfold inducedPrior
  aesop
