-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.mixture_sum_one
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMixture.mixture_sum_one {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw : ∑ h, w h = 1)
    (hp : ∀ h, ∑ j, p h j = 1) : ∑ j, mixture w p j = 1 := by sorry
