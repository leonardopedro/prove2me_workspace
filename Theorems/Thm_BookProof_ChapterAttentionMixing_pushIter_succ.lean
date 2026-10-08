-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.pushIter_succ
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixing
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMixing


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


theorem BookProof.ChapterAttentionMixing.pushIter_succ (P : Fin m → Fin m → ℝ) (n : ℕ) (p : Fin m → ℝ) :
    pushIter P (n + 1) p = push P (pushIter P n p) := by sorry
