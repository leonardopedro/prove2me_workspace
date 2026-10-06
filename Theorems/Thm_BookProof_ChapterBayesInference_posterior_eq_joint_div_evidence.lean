-- Generated from ChapterBayesInference.lean — theorem BookProof.ChapterBayesInference.posterior_eq_joint_div_evidence
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}


open scoped BigOperators



theorem BookProof.ChapterBayesInference.posterior_eq_joint_div_evidence (y : Y) (x : X) :
    posterior prior L y x = joint prior L x y / evidence prior L y := by sorry
