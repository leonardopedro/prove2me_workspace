-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.mixture_nonneg
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMixture
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMixture

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMixture.mixture_nonneg {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw : ∀ h, 0 ≤ w h)
    (hp : ∀ h j, 0 ≤ p h j) (j : Fin m) : 0 ≤ mixture w p j := by sorry
