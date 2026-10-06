-- Generated from ChapterE3.lean — theorem BookProof.ChapterE3.eulerJ_sq
import Mathlib
import Definitions.Def_ChapterE3
open BookProof.ChapterE3

variable {n : ℕ}


open scoped Matrix BigOperators



theorem BookProof.ChapterE3.eulerJ_sq (l w : Fin n → ℝ)
    (hll : ∑ i, l i * l i = 1) (hww : ∑ i, w i * w i = 1)
    (hlw : ∑ i, l i * w i = 0) :
    eulerJ l w * eulerJ l w = - (Matrix.vecMulVec l l + Matrix.vecMulVec w w) := by sorry
