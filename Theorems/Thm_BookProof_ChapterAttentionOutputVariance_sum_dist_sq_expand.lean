-- Generated from ChapterAttentionOutputVariance.lean — theorem BookProof.ChapterAttentionOutputVariance.sum_dist_sq_expand
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


theorem BookProof.ChapterAttentionOutputVariance.sum_dist_sq_expand {p : Fin m → ℝ} (hp : ∑ j, p j = 1) (v : Fin m → E) (c : E) :
    ∑ j, p j * ‖v j - c‖ ^ 2
      = (∑ j, p j * ‖v j‖ ^ 2) - 2 * ⟪observableExpectation p v, c⟫ + ‖c‖ ^ 2 := by sorry
