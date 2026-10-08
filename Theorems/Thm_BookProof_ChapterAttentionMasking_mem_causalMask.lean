-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.mem_causalMask
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMasking.mem_causalMask {i l : Fin m} : l ∈ causalMask m i ↔ l ≤ i := by sorry
