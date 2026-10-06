-- Generated from ChapterBayesInference.lean — solution of BookProof.ChapterBayesInference.posterior_eq_joint_div_evidence
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference



open scoped BigOperators


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (y : Y) (x : X) :
    posterior prior L y x = joint prior L x y / evidence prior L y := by

  rfl
