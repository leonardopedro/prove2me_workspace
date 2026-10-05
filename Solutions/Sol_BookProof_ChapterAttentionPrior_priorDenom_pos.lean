-- Generated from ChapterAttentionPrior.lean — solution of BookProof.ChapterAttentionPrior.priorDenom_pos
import Mathlib
import Definitions.Def_ChapterAttentionPrior
open BookProof.ChapterAttentionPrior



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {w : Fin m → ℝ} (hw : ∀ j, 0 < w j) (beta : ℝ) (s : Fin m → ℝ)
    (i : Fin m) : 0 < ∑ l, w l * Real.exp (beta * s l) :=
  Finset.sum_pos' (fun l _ => (mul_pos (hw l) (Real.exp_pos _)).le)
      ⟨i, Finset.mem_univ i, mul_pos (hw i) (Real.exp_pos _)⟩
