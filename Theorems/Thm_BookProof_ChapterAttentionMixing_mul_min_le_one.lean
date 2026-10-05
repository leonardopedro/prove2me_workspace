-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.mul_min_le_one
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


theorem BookProof.ChapterAttentionMixing.mul_min_le_one {P : Fin m → Fin m → ℝ} {eps : ℝ} (hP : IsStochastic P)
    (hmin : ∀ i j, eps ≤ P i j) (i : Fin m) : (m : ℝ) * eps ≤ 1 := by sorry
