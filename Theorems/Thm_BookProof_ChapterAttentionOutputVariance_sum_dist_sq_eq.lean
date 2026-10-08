-- Generated from ChapterAttentionOutputVariance.lean — theorem BookProof.ChapterAttentionOutputVariance.sum_dist_sq_eq
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


theorem BookProof.ChapterAttentionOutputVariance.sum_dist_sq_eq {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E) (c : E) :
    ∑ j, p j * ‖v j - c‖ ^ 2
      = outputVariance p v + ‖observableExpectation p v - c‖ ^ 2 := by sorry
