-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.le_shannonEntropy_multiHead
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionEntropy
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionMixture


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionEntropy

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionMixture.le_shannonEntropy_multiHead {w : Fin H → ℝ} (hw0 : ∀ h, 0 ≤ w h) (hw : ∑ h, w h = 1)
    (beta : Fin H → ℝ) (s : Fin H → Fin m → ℝ) :
    ∑ h, w h * shannonEntropy (scoreSoftmax (beta h) (s h))
      ≤ shannonEntropy (multiHead w beta s) := by sorry
