-- Generated from ChapterDeepLearningMAP.lean — theorem BookProof.ChapterDeepLearningMAP.exp_logObjective
import Mathlib
import Definitions.Def_ChapterDeepLearningMAP
open BookProof.ChapterDeepLearningMAP

variable {Model Data : Type*}




theorem BookProof.ChapterDeepLearningMAP.exp_logObjective (prior : Model → ℝ) (likelihood : Model → Data → ℝ)
    (d : Data) (hprior : ∀ m, 0 < prior m)
    (hlike : ∀ m, 0 < likelihood m d) (m : Model) :
    Real.exp (logObjective prior likelihood d m) =
      posteriorWeight prior likelihood d m := by sorry
