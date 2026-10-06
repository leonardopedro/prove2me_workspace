-- Generated from ChapterDeepLearningSampling.lean — solution of BookProof.ChapterDeepLearningSampling.posterior_sum_one
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
theorem solution (seedProb : Seed → ℝ) (train : Seed → Model)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hd : 0 < evidence seedProb train likelihood d) :
    ∑ m, posterior seedProb train likelihood d m = 1 := by

  unfold posterior
  rw [← Finset.sum_div, div_eq_iff] <;> aesop
