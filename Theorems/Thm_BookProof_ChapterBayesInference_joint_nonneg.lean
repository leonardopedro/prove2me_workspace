-- Generated from ChapterBayesInference.lean — theorem BookProof.ChapterBayesInference.joint_nonneg
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}


open scoped BigOperators



omit [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y] in
theorem BookProof.ChapterBayesInference.joint_nonneg (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (x : X) (y : Y) : 0 ≤ joint prior L x y := by sorry
