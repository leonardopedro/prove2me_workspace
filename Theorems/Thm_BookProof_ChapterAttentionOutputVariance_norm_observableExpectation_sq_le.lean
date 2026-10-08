-- Generated from ChapterAttentionOutputVariance.lean — theorem BookProof.ChapterAttentionOutputVariance.norm_observableExpectation_sq_le
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionOutputVariance
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation
open BookProof.ChapterAttentionOutputVariance


open scoped BigOperators RealInnerProductSpace

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.ChapterAttentionOutputVariance.norm_observableExpectation_sq_le {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hp : ∑ j, p j = 1) (v : Fin m → E) :
    ‖observableExpectation p v‖ ^ 2 ≤ ∑ j, p j * ‖v j‖ ^ 2 := by sorry
