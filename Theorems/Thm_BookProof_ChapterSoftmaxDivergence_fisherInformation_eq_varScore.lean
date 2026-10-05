-- Generated from ChapterSoftmaxDivergence.lean — theorem BookProof.ChapterSoftmaxDivergence.fisherInformation_eq_varScore
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
open BookProof.ChapterSoftmaxDivergence

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxDivergence.fisherInformation_eq_varScore (beta : ℝ) (s : Fin m → ℝ) :
    fisherInformation beta s = varScore beta s := by sorry
