-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.observableExpectation_mixture
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMixture.observableExpectation_mixture (w : Fin H → ℝ) (p : Fin H → Fin m → ℝ)
    (v : Fin m → E) :
    observableExpectation (mixture w p) v = ∑ h, w h • observableExpectation (p h) v := by sorry
