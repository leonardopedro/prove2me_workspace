-- Generated from ChapterAttentionMarkov.lean — solution of BookProof.ChapterAttentionMarkov.l1dist_nonneg
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p q : Fin m → ℝ) : 0 ≤ l1dist p q := Finset.sum_nonneg fun _ _ => abs_nonneg _
