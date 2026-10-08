-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.flipEquiv_apply_self
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}


theorem BookProof.ChapterScaledDotProduct.flipEquiv_apply_self (i : Fin d) (x : Fin d → Bool) :
    (flipEquiv i x) i = !(x i) := by sorry
