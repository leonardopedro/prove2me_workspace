-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.sum_sgn_eq_zero
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct

variable {d : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterScaledDotProduct.sum_sgn_eq_zero (i : Fin d) : ∑ x : (Fin d → Bool), sgn (x i) = 0 := by sorry
