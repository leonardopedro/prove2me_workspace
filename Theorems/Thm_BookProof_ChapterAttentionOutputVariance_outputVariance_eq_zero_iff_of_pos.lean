-- Generated from ChapterAttentionOutputVariance.lean — theorem BookProof.ChapterAttentionOutputVariance.outputVariance_eq_zero_iff_of_pos
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


theorem BookProof.ChapterAttentionOutputVariance.outputVariance_eq_zero_iff_of_pos {p : Fin m → ℝ} (hp0 : ∀ j, 0 < p j)
    (v : Fin m → E) :
    outputVariance p v = 0 ↔ ∀ j, v j = observableExpectation p v := by sorry
