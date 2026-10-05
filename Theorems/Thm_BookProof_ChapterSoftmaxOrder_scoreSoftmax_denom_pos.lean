-- Generated from ChapterSoftmaxOrder.lean — theorem BookProof.ChapterSoftmaxOrder.scoreSoftmax_denom_pos
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxOrder.scoreSoftmax_denom_pos (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    0 < ∑ l, Real.exp (beta * s l) := by sorry
