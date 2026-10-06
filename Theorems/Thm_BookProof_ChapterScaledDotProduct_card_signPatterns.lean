-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.card_signPatterns
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct

variable {d : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterScaledDotProduct.card_signPatterns : Fintype.card (Fin d → Bool) = 2 ^ d := by sorry
