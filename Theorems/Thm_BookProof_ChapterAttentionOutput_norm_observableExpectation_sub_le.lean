-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.norm_observableExpectation_sub_le
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterA4
open BookProof.ChapterObservableExpectation

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionOutput.norm_observableExpectation_sub_le (p q : Fin m → ℝ) {v : Fin m → E} {C : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) :
    ‖observableExpectation p v - observableExpectation q v‖ ≤ (∑ j, |p j - q j|) * C := by sorry
