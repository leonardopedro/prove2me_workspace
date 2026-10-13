-- Generated from ChapterAttentionMasking.lean — solution of BookProof.ChapterAttentionMasking.mem_causalMask
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
open BookProof.ChapterAttentionMasking



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i l : Fin m} : l ∈ causalMask m i ↔ l ≤ i := by

  simp [causalMask]
