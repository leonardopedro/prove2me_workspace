-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.flipEquiv_apply_self
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct

variable {d : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterScaledDotProduct.flipEquiv_apply_self (i : Fin d) (x : Fin d → Bool) :
    (flipEquiv i x) i = !(x i) := by sorry
