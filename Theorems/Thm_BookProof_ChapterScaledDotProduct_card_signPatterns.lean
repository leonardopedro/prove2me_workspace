-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.card_signPatterns
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}


theorem BookProof.ChapterScaledDotProduct.card_signPatterns : Fintype.card (Fin d → Bool) = 2 ^ d := by sorry
