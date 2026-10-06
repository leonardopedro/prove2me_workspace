-- Generated from ChapterBayesInference.lean — theorem BookProof.ChapterBayesInference.evidence_eq_marginal
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}


open scoped BigOperators



omit [Fintype Y] [DecidableEq X] [DecidableEq Y] in
theorem BookProof.ChapterBayesInference.evidence_eq_marginal (y : Y) : evidence prior L y = ∑ x, joint prior L x y := by sorry
