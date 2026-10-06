-- Generated from ChapterSequentialBayes.lean — solution of BookProof.ChapterSequentialBayes.posterior_eq_bayesUpdate
import Mathlib
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterSequentialBayes



open scoped BigOperators


variable {X : Type*} [Fintype X]

variable {X : Type*} [Fintype X]

set_option maxHeartbeats 1000000 in
theorem solution {Y : Type*}
    (prior : X → ℝ) (L : X → Y → ℝ) (y : Y) :
    BookProof.ChapterBayesInference.posterior prior L y = bayesUpdate prior (fun x => L x y) := by

  funext x
  rfl
