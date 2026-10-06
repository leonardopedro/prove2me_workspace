-- Generated from ChapterBayesInference.lean — solution of BookProof.ChapterBayesInference.posterior_sum_one
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference



open scoped BigOperators


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (y : Y) (hy : 0 < evidence prior L y) :
    ∑ x, posterior prior L y x = 1 := by

  convert div_self hy.ne';
  unfold posterior evidence; simp [ Finset.sum_div _ _ _ ] ;
