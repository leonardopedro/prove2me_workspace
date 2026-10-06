-- Generated from ChapterDeepLearningMAP.lean — theorem BookProof.ChapterDeepLearningMAP.logObjective_le_iff
import Mathlib
import Definitions.Def_ChapterDeepLearningMAP
open BookProof.ChapterDeepLearningMAP

variable {Model Data : Type*}




theorem BookProof.ChapterDeepLearningMAP.logObjective_le_iff (prior : Model → ℝ)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hprior : ∀ m, 0 < prior m) (hlike : ∀ m, 0 < likelihood m d)
    (a b : Model) :
    logObjective prior likelihood d a ≤ logObjective prior likelihood d b ↔
      posteriorWeight prior likelihood d a ≤ posteriorWeight prior likelihood d b := by sorry
