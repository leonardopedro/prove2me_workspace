-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.sgn_not
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct

variable {d : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterScaledDotProduct.sgn_not (b : Bool) : sgn (!b) = -sgn b := by sorry
