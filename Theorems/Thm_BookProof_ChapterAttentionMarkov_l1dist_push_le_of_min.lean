-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.l1dist_push_le_of_min
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMarkov.l1dist_push_le_of_min {P : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} {eps : ℝ}
    (hP : IsStochastic P) (hmin : ∀ i j, eps ≤ P i j) (hp : IsProb p) (hq : IsProb q) :
    l1dist (push P p) (push P q) ≤ (1 - m * eps) * l1dist p q := by sorry
