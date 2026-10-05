-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.pushIter_zero
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixing
open BookProof.ChapterAttentionMixing

variable {m : ℕ}


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMixing.pushIter_zero (P : Fin m → Fin m → ℝ) (p : Fin m → ℝ) : pushIter P 0 p = p := by sorry
