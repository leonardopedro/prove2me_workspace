-- Generated from ChapterAttentionOutputVariance.lean — theorem BookProof.ChapterAttentionOutputVariance.outputVariance_eq_sub
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionOutputVariance
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation
open BookProof.ChapterAttentionOutputVariance

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


open scoped BigOperators RealInnerProductSpace

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionOutputVariance.outputVariance_eq_sub {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E) :
    outputVariance p v = (∑ j, p j * ‖v j‖ ^ 2) - ‖observableExpectation p v‖ ^ 2 := by sorry
