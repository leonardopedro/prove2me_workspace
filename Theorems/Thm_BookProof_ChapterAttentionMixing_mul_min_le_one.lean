-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.mul_min_le_one
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


theorem BookProof.ChapterAttentionMixing.mul_min_le_one {P : Fin m → Fin m → ℝ} {eps : ℝ} (hP : IsStochastic P)
    (hmin : ∀ i j, eps ≤ P i j) (i : Fin m) : (m : ℝ) * eps ≤ 1 := by sorry
