-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.pushIter_succ
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMixing
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMixing

variable {m : ℕ}


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionMixing.pushIter_succ (P : Fin m → Fin m → ℝ) (n : ℕ) (p : Fin m → ℝ) :
    pushIter P (n + 1) p = push P (pushIter P n p) := by sorry
