-- Generated from ChapterDeepLearningMAP.lean — theorem BookProof.ChapterDeepLearningMAP.posterior_le_iff_weight
import Mathlib
import Definitions.Def_ChapterDeepLearningMAP
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterDeepLearningMAP

variable {Model Data : Type*}
variable [Fintype Model]




theorem BookProof.ChapterDeepLearningMAP.posterior_le_iff_weight (prior : Model → ℝ)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence prior likelihood d)
    (a b : Model) :
    BookProof.ChapterBayesInference.posterior prior likelihood d a ≤
      BookProof.ChapterBayesInference.posterior prior likelihood d b ↔
    posteriorWeight prior likelihood d a ≤ posteriorWeight prior likelihood d b := by sorry
