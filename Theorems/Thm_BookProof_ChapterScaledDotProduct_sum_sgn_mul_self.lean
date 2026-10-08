-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.sum_sgn_mul_self
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}


theorem BookProof.ChapterScaledDotProduct.sum_sgn_mul_self (i : Fin d) :
    ∑ x : (Fin d → Bool), sgn (x i) * sgn (x i) = 2 ^ d := by sorry
