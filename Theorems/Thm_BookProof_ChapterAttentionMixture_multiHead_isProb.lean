-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.multiHead_isProb
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMixture.multiHead_isProb {w : Fin H → ℝ} (hw0 : ∀ h, 0 ≤ w h) (hw : ∑ h, w h = 1)
    (beta : Fin H → ℝ) (s : Fin H → Fin m → ℝ) (j₀ : Fin m) :
    (∀ j, 0 ≤ multiHead w beta s j) ∧ ∑ j, multiHead w beta s j = 1 := by sorry
