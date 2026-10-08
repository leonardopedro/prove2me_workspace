-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.sum_sgn_mul_eq_zero
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}


theorem BookProof.ChapterScaledDotProduct.sum_sgn_mul_eq_zero {i j : Fin d} (hij : i ≠ j) :
    ∑ x : (Fin d → Bool), sgn (x i) * sgn (x j) = 0 := by sorry
