-- Generated from ChapterDeepLearningMAP.lean — solution of BookProof.ChapterDeepLearningMAP.exp_logObjective
import Mathlib
import Definitions.Def_ChapterDeepLearningMAP
open BookProof.ChapterDeepLearningMAP




variable {Model Data : Type*}

variable {Model Data : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (prior : Model → ℝ) (likelihood : Model → Data → ℝ)
    (d : Data) (hprior : ∀ m, 0 < prior m)
    (hlike : ∀ m, 0 < likelihood m d) (m : Model) :
    Real.exp (logObjective prior likelihood d m) =
      posteriorWeight prior likelihood d m := by

  unfold logObjective posteriorWeight
  rw [Real.exp_add, Real.exp_log (hprior m), Real.exp_log (hlike m)]
