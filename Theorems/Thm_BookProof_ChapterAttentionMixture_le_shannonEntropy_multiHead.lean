-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.le_shannonEntropy_multiHead
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMixture.le_shannonEntropy_multiHead {w : Fin H → ℝ} (hw0 : ∀ h, 0 ≤ w h) (hw : ∑ h, w h = 1)
    (beta : Fin H → ℝ) (s : Fin H → Fin m → ℝ) :
    ∑ h, w h * shannonEntropy (scoreSoftmax (beta h) (s h))
      ≤ shannonEntropy (multiHead w beta s) := by sorry
