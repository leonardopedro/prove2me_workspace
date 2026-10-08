-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.flipEquiv_apply_of_ne
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}


theorem BookProof.ChapterScaledDotProduct.flipEquiv_apply_of_ne {i j : Fin d} (h : j ≠ i) (x : Fin d → Bool) :
    (flipEquiv i x) j = x j := by sorry
