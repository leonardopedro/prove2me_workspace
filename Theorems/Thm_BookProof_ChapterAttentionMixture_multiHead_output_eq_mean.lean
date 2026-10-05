-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.multiHead_output_eq_mean
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterObservableExpectation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMixture.multiHead_output_eq_mean (w : Fin H → ℝ) (beta : Fin H → ℝ)
    (s : Fin H → Fin m → ℝ) (v : Fin m → E) :
    observableExpectation (multiHead w beta s) v
      = ∑ h, w h • headOutput (beta h) (s h) v := by sorry
