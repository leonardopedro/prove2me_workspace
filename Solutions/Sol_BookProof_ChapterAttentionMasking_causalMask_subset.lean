-- Generated from ChapterAttentionMasking.lean — solution of BookProof.ChapterAttentionMasking.causalMask_subset
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Theorems.Thm_BookProof_ChapterAttentionMasking_mem_causalMask
open BookProof.ChapterAttentionMasking



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i i' : Fin m} (h : i ≤ i') : causalMask m i ⊆ causalMask m i' := fun _ hl => mem_causalMask.2 (le_trans (mem_causalMask.1 hl) h)
