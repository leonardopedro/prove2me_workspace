-- Generated from ChapterSoftmaxDivergence.lean — solution of BookProof.ChapterSoftmaxDivergence.fisherInformation_eq_varScore
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
open BookProof.ChapterSoftmaxDivergence



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) :
    fisherInformation beta s = varScore beta s := rfl
