-- Generated from ChapterBayesInference.lean — theorem BookProof.ChapterBayesInference.posterior_sum_one
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}


open scoped BigOperators



theorem BookProof.ChapterBayesInference.posterior_sum_one (y : Y) (hy : 0 < evidence prior L y) :
    ∑ x, posterior prior L y x = 1 := by sorry
