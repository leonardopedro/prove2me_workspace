-- Generated from ChapterAttentionPrior.lean — solution of BookProof.ChapterAttentionPrior.priorSoftmax_eq_posterior
import Mathlib
import Definitions.Def_ChapterAttentionPrior
open BookProof.ChapterAttentionPrior



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (w : Fin m → ℝ) (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w beta s j
      = posterior w (fun l (_ : Unit) => Real.exp (beta * s l)) () j := rfl
