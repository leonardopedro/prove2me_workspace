-- Generated from ChapterAttentionMarkov.lean — solution of BookProof.ChapterAttentionMarkov.push_compose
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P Q : Fin m → Fin m → ℝ) (p : Fin m → ℝ) (j : Fin m) :
    push (compose P Q) p j = push Q (push P p) j := by

  simp only [push, compose, Finset.mul_sum, Finset.sum_mul]
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun i _ => by ring
