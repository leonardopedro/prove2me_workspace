-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.l1dist_push_le
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMarkov.l1dist_push_le {P : Fin m → Fin m → ℝ} (hP : IsStochastic P) (p q : Fin m → ℝ) :
    l1dist (push P p) (push P q) ≤ l1dist p q := by sorry
