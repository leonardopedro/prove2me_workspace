-- Generated from ChapterSinusoidalPosition.lean — solution of BookProof.ChapterSinusoidalPosition.scoreSoftmax_sinusoidal_shift
import Mathlib
import Definitions.Def_ChapterSinusoidalPosition
import Theorems.Thm_BookProof_ChapterSinusoidalPosition_peInner_shift
open BookProof.ChapterSinusoidalPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (beta : ℝ) (w : Fin n → ℝ) (p t : ℝ)
    (k : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => peInner w (p + t) (k l + t)) j
      = scoreSoftmax beta (fun l => peInner w p (k l)) j := by

  congr 1
  funext l
  exact peInner_shift w p (k l) t
