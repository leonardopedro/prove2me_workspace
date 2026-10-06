-- Generated from ChapterBayesInference.lean — solution of BookProof.ChapterBayesInference.posterior_nonneg
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference



open scoped BigOperators


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}

set_option maxHeartbeats 1000000 in
omit [Fintype Y] [DecidableEq X] [DecidableEq Y] in
theorem solution (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (y : Y) (x : X) : 0 ≤ posterior prior L y x := by

  exact div_nonneg ( mul_nonneg ( hprior x ) ( hL x y ) ) ( Finset.sum_nonneg fun _ _ => mul_nonneg
      ( hprior _ ) ( hL _ _ ) )
