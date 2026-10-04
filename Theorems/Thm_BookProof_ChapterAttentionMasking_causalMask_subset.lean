-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.causalMask_subset
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMasking.causalMask_subset {i i' : Fin m} (h : i ≤ i') : causalMask m i ⊆ causalMask m i' := by sorry
