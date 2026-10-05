-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.causalMask_subset
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMasking.causalMask_subset {i i' : Fin m} (h : i ≤ i') : causalMask m i ⊆ causalMask m i' := by sorry
