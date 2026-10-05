-- Generated from ChapterSoftmaxDivergence.lean — solution of BookProof.ChapterSoftmaxDivergence.klDiv_eq_crossEntropy_sub_shannonEntropy
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
open BookProof.ChapterSoftmaxDivergence



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {p q : Fin m → ℝ}
    (hq0 : ∀ j, 0 < q j) :
    klDiv p q = crossEntropy p q - shannonEntropy p := by

  have hterm : ∀ j : Fin m,
      p j * Real.log (p j / q j) = -(p j * Real.log (q j)) + p j * Real.log (p j) := by
    intro j
    rcases eq_or_ne (p j) 0 with h | h
    · simp [h]
    · rw [Real.log_div h (ne_of_gt (hq0 j))]; ring
  rw [klDiv, Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_add_distrib,
    crossEntropy, shannonEntropy, Finset.sum_neg_distrib]
  ring
