-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.shannonEntropy_eq_sum_negMulLog
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixture
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMixture.shannonEntropy_eq_sum_negMulLog (p : Fin m → ℝ) :
    shannonEntropy p = ∑ j, Real.negMulLog (p j) := by sorry
