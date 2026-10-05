-- Generated from ChapterSinusoidalPosition.lean — theorem BookProof.ChapterSinusoidalPosition.scoreSoftmax_sinusoidal_ge
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


theorem BookProof.ChapterSinusoidalPosition.scoreSoftmax_sinusoidal_ge {m : ℕ} {beta : ℝ} (hb : 0 ≤ beta) (w : Fin n → ℝ)
    (p : ℝ) (k : Fin m → ℝ) (j : Fin m) :
    Real.exp (-(beta * (2 * n))) / (m : ℝ)
      ≤ scoreSoftmax beta (fun l => peInner w p (k l)) j := by sorry
