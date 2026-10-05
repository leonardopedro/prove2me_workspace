-- Generated from ChapterSoftmaxOrder.lean — theorem BookProof.ChapterSoftmaxOrder.softmax_le_iff_inner_le
import Mathlib
import Definitions.Def_ChapterSoftmaxOrder
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxOrder.softmax_le_iff_inner_le {n : ℕ} {beta : ℝ} (hbeta : 0 < beta)
    (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n)) (i j : Fin m) :
    softmax beta q k i ≤ softmax beta q k j ↔
      (inner ℝ q (k i) : ℝ) ≤ inner ℝ q (k j) := by sorry
