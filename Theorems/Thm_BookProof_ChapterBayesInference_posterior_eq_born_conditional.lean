-- Generated from ChapterBayesInference.lean — theorem BookProof.ChapterBayesInference.posterior_eq_born_conditional
import Mathlib
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}


open scoped BigOperators



theorem BookProof.ChapterBayesInference.posterior_eq_born_conditional (hprior : ∀ x, 0 ≤ prior x) (hL : ∀ x y, 0 ≤ L x y)
    (y : Y) (x : X) :
    posterior prior L y x =
      (Real.sqrt (joint prior L x y)) ^ 2 / ∑ x', (Real.sqrt (joint prior L x' y)) ^ 2 := by sorry
