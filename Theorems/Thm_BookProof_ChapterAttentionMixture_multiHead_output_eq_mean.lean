-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.multiHead_output_eq_mean
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterObservableExpectation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMixture.multiHead_output_eq_mean (w : Fin H → ℝ) (beta : Fin H → ℝ)
    (s : Fin H → Fin m → ℝ) (v : Fin m → E) :
    observableExpectation (multiHead w beta s) v
      = ∑ h, w h • headOutput (beta h) (s h) v := by sorry
