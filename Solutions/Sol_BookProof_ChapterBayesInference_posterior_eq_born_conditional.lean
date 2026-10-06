-- Generated from ChapterBayesInference.lean — solution of BookProof.ChapterBayesInference.posterior_eq_born_conditional
import Mathlib
import Definitions.Def_ChapterBayesInference
import Theorems.Thm_BookProof_ChapterBayesInference_posterior_eq_joint_div_evidence
open BookProof.ChapterBayesInference



open scoped BigOperators


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (y : Y) (x : X) :
    posterior prior L y x =
      (Real.sqrt (joint prior L x y)) ^ 2 / ∑ x', (Real.sqrt (joint prior L x' y)) ^ 2 := by

  rw [ posterior_eq_joint_div_evidence, Finset.sum_congr rfl fun _ _ => Real.sq_sqrt (
      by unfold joint; exact mul_nonneg ( hprior _ ) ( hL _ _ ) ) ];
  rw [ Real.sq_sqrt ( by exact mul_nonneg ( hprior x ) ( hL x y ) ) ] ; rfl
