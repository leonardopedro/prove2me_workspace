-- Generated from ChapterSoftmaxSharpness.lean — theorem BookProof.ChapterSoftmaxSharpness.scoreSoftmax_zero
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness


open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}


theorem BookProof.ChapterSoftmaxSharpness.scoreSoftmax_zero (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax 0 s j = 1 / m := by sorry
