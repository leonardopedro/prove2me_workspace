-- Generated from ChapterAttentionOutputVariance.lean — theorem BookProof.ChapterAttentionOutputVariance.outputVariance_nonneg
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


theorem BookProof.ChapterAttentionOutputVariance.outputVariance_nonneg {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (v : Fin m → E) :
    0 ≤ outputVariance p v := by sorry
