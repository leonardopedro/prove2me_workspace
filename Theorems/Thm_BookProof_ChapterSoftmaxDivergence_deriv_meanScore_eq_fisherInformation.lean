-- Generated from ChapterSoftmaxDivergence.lean — theorem BookProof.ChapterSoftmaxDivergence.deriv_meanScore_eq_fisherInformation
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
open BookProof.ChapterSoftmaxDivergence

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxDivergence.deriv_meanScore_eq_fisherInformation (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    deriv (fun b : ℝ => meanScore b s) beta = fisherInformation beta s := by sorry
