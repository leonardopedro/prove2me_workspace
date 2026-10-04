-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.pushIter_zero
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMixing
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMixing

variable {m : ℕ}


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionMixing.pushIter_zero (P : Fin m → Fin m → ℝ) (p : Fin m → ℝ) : pushIter P 0 p = p := by sorry
