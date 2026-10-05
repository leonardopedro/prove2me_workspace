-- Generated from ChapterAttentionPrior.lean — theorem BookProof.ChapterAttentionPrior.priorSoftmax_eq_posterior
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionPrior
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterAttentionPrior

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionPrior.priorSoftmax_eq_posterior (w : Fin m → ℝ) (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    priorSoftmax w beta s j
      = posterior w (fun l (_ : Unit) => Real.exp (beta * s l)) () j := by sorry
