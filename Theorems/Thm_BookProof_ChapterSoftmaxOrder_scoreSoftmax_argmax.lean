-- Generated from ChapterSoftmaxOrder.lean — theorem BookProof.ChapterSoftmaxOrder.scoreSoftmax_argmax
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterSoftmaxOrder
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxOrder.scoreSoftmax_argmax {beta : ℝ} (hbeta : 0 < beta) (s : Fin m → ℝ) (j : Fin m)
    (hj : ∀ l, s l ≤ s j) (i : Fin m) :
    scoreSoftmax beta s i ≤ scoreSoftmax beta s j := by sorry
