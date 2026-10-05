-- Generated from ChapterAttentionOutputVariance.lean — theorem BookProof.ChapterAttentionOutputVariance.headOutput_minimizes
import Definitions.Def_ChapterObservableExpectation
import Mathlib
import Definitions.Def_ChapterAttentionOutputVariance
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionOutputVariance

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


open scoped BigOperators RealInnerProductSpace

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionOutputVariance.headOutput_minimizes (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) (i : Fin m) (c : E) :
    ∑ j, scoreSoftmax beta s j * ‖v j - headOutput beta s v‖ ^ 2
      ≤ ∑ j, scoreSoftmax beta s j * ‖v j - c‖ ^ 2 := by sorry
