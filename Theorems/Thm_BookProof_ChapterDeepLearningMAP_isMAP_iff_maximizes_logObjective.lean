-- Generated from ChapterDeepLearningMAP.lean — theorem BookProof.ChapterDeepLearningMAP.isMAP_iff_maximizes_logObjective
import Mathlib
import Definitions.Def_ChapterDeepLearningMAP
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterDeepLearningMAP

variable {Model Data : Type*}
variable [Fintype Model]




theorem BookProof.ChapterDeepLearningMAP.isMAP_iff_maximizes_logObjective (prior : Model → ℝ)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hprior : ∀ m, 0 < prior m) (hlike : ∀ m, 0 < likelihood m d)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence prior likelihood d)
    (best : Model) :
    (∀ m, BookProof.ChapterBayesInference.posterior prior likelihood d m ≤
      BookProof.ChapterBayesInference.posterior prior likelihood d best) ↔
    (∀ m, logObjective prior likelihood d m ≤
      logObjective prior likelihood d best) := by sorry
