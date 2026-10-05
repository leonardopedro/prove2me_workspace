-- Generated from ChapterAttentionMarkov.lean — solution of BookProof.ChapterAttentionMarkov.push_nonneg
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {P : Fin m → Fin m → ℝ} {p : Fin m → ℝ} (hP : IsStochastic P)
    (hp : ∀ j, 0 ≤ p j) (j : Fin m) : 0 ≤ push P p j := Finset.sum_nonneg fun i _ => mul_nonneg (hp i) (hP.1 i j)
