-- Generated from ChapterSinusoidalPosition.lean — theorem BookProof.ChapterSinusoidalPosition.scoreSoftmax_sinusoidal_shift
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSinusoidalPosition
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSinusoidalPosition

variable {n : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterSinusoidalPosition.scoreSoftmax_sinusoidal_shift {m : ℕ} (beta : ℝ) (w : Fin n → ℝ) (p t : ℝ)
    (k : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => peInner w (p + t) (k l + t)) j
      = scoreSoftmax beta (fun l => peInner w p (k l)) j := by sorry
