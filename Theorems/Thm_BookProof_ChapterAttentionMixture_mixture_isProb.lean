-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.mixture_isProb
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixture
open BookProof.ChapterAttentionMixture


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionMixture.mixture_isProb {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw0 : ∀ h, 0 ≤ w h)
    (hw : ∑ h, w h = 1) (hp0 : ∀ h j, 0 ≤ p h j) (hp : ∀ h, ∑ j, p h j = 1) :
    (∀ j, 0 ≤ mixture w p j) ∧ ∑ j, mixture w p j = 1 := by sorry
