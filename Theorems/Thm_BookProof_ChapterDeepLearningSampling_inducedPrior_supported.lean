-- Generated from ChapterDeepLearningSampling.lean — theorem BookProof.ChapterDeepLearningSampling.inducedPrior_supported
import Mathlib
import Definitions.Def_ChapterDeepLearningSampling
open BookProof.ChapterDeepLearningSampling

variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]


open scoped BigOperators



theorem BookProof.ChapterDeepLearningSampling.inducedPrior_supported (seedProb : Seed → ℝ) (train : Seed → Model)
    (admissible : Model → Prop)
    (htrain : ∀ s, admissible (train s)) {m : Model} (hm : ¬ admissible m) :
    inducedPrior seedProb train m = 0 := by sorry
