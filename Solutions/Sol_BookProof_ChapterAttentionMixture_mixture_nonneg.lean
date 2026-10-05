-- Generated from ChapterAttentionMixture.lean — solution of BookProof.ChapterAttentionMixture.mixture_nonneg
import Mathlib
import Definitions.Def_ChapterAttentionMixture
open BookProof.ChapterAttentionMixture



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw : ∀ h, 0 ≤ w h)
    (hp : ∀ h j, 0 ≤ p h j) (j : Fin m) : 0 ≤ mixture w p j := Finset.sum_nonneg fun h _ => mul_nonneg (hw h) (hp h j)
