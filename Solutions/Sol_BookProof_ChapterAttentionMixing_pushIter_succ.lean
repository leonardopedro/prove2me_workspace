-- Generated from ChapterAttentionMixing.lean — solution of BookProof.ChapterAttentionMixing.pushIter_succ
import Mathlib
import Definitions.Def_ChapterAttentionMixing
open BookProof.ChapterAttentionMixing



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P : Fin m → Fin m → ℝ) (n : ℕ) (p : Fin m → ℝ) :
    pushIter P (n + 1) p = push P (pushIter P n p) := Function.iterate_succ_apply' _ _ _
