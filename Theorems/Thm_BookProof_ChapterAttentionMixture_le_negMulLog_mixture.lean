-- Generated from ChapterAttentionMixture.lean — theorem BookProof.ChapterAttentionMixture.le_negMulLog_mixture
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixture
open BookProof.ChapterAttentionMixture


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionMixture.le_negMulLog_mixture {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw0 : ∀ h, 0 ≤ w h)
    (hw : ∑ h, w h = 1) (hp0 : ∀ h j, 0 ≤ p h j) (j : Fin m) :
    ∑ h, w h * Real.negMulLog (p h j) ≤ Real.negMulLog (mixture w p j) := by sorry
