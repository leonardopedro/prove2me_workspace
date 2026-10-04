-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.l1dist_pushIter_le
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMixing
import Definitions.Def_ChapterDutchBook
import Definitions.Def_ChapterA4
open BookProof.ChapterDutchBook
open BookProof.ChapterAttentionMixing

variable {m : ℕ}


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionMixing.l1dist_pushIter_le {P : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} {eps : ℝ}
    (hP : IsStochastic P) (hmin : ∀ i j, eps ≤ P i j) (hp : IsProb p) (hq : IsProb q)
    (n : ℕ) :
    l1dist (pushIter P n p) (pushIter P n q) ≤ (1 - m * eps) ^ n * l1dist p q := by sorry
