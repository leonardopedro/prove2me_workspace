-- Generated from ChapterAttentionOutputVariance.lean — theorem BookProof.ChapterAttentionOutputVariance.observableExpectation_minimizes
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionOutputVariance
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterA4
open BookProof.ChapterObservableExpectation
open BookProof.ChapterAttentionOutputVariance

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


open scoped BigOperators RealInnerProductSpace

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionOutputVariance.observableExpectation_minimizes {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E)
    (c : E) :
    ∑ j, p j * ‖v j - observableExpectation p v‖ ^ 2 ≤ ∑ j, p j * ‖v j - c‖ ^ 2 := by sorry
