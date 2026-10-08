-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.l1dist_nonneg
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMarkov.l1dist_nonneg (p q : Fin m → ℝ) : 0 ≤ l1dist p q := by sorry
