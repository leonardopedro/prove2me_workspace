-- Generated from ChapterBayesInference.lean — theorem BookProof.ChapterBayesInference.joint_sum_one
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference


open scoped BigOperators


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]

variable {prior : X → ℝ} {L : X → Y → ℝ}

omit [DecidableEq X] [DecidableEq Y] in
theorem BookProof.ChapterBayesInference.joint_sum_one (hprior_sum : ∑ x, prior x = 1) (hL_row : ∀ x, ∑ y, L x y = 1) :
    ∑ x, ∑ y, joint prior L x y = 1 := by sorry
