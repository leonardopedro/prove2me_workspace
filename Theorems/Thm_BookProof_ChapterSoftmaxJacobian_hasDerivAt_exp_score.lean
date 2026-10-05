-- Generated from ChapterSoftmaxJacobian.lean — theorem BookProof.ChapterSoftmaxJacobian.hasDerivAt_exp_score
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
open BookProof.ChapterSoftmaxJacobian

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterSoftmaxJacobian.hasDerivAt_exp_score (beta t₀ : ℝ) (c : ℝ) :
    HasDerivAt (fun t : ℝ => Real.exp (beta * (c + t)))
      (beta * Real.exp (beta * (c + t₀))) t₀ := by sorry
