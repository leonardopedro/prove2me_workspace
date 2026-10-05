-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.norm_observableExpectation_sub_le
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation
open BookProof.ChapterAttentionOutput

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionOutput.norm_observableExpectation_sub_le (p q : Fin m → ℝ) {v : Fin m → E} {C : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) :
    ‖observableExpectation p v - observableExpectation q v‖ ≤ (∑ j, |p j - q j|) * C := by sorry
