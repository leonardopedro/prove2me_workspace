-- Generated from ChapterAttentionMarkov.lean — solution of BookProof.ChapterAttentionMarkov.push_sum_one
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
    (hp : ∑ j, p j = 1) : ∑ j, push P p j = 1 := by

  calc ∑ j, push P p j = ∑ i, ∑ j, p i * P i j := by
        simp only [push]
        exact Finset.sum_comm
    _ = ∑ i, p i := by
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [← Finset.mul_sum, hP.2 i, mul_one]
    _ = 1 := hp
