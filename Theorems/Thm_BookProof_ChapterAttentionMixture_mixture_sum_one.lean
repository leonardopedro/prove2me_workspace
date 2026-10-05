-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.mixture_sum_one
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixture
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMixture.mixture_sum_one {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw : ∑ h, w h = 1)
    (hp : ∀ h, ∑ j, p h j = 1) : ∑ j, mixture w p j = 1 := by sorry
