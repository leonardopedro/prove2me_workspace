-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.mem_causalMask
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMasking.mem_causalMask {i l : Fin m} : l ∈ causalMask m i ↔ l ≤ i := by sorry
