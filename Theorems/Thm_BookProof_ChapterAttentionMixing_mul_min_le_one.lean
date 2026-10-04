-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.mul_min_le_one
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMixing
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMixing

variable {m : ℕ}


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionMixing.mul_min_le_one {P : Fin m → Fin m → ℝ} {eps : ℝ} (hP : IsStochastic P)
    (hmin : ∀ i j, eps ≤ P i j) (i : Fin m) : (m : ℝ) * eps ≤ 1 := by sorry
