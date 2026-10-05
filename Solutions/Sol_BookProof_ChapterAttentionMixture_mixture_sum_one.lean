-- Generated from ChapterAttentionMixture.lean — solution of BookProof.ChapterAttentionMixture.mixture_sum_one
import Mathlib
import Definitions.Def_ChapterAttentionMixture
open BookProof.ChapterAttentionMixture



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m H : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {w : Fin H → ℝ} {p : Fin H → Fin m → ℝ} (hw : ∑ h, w h = 1)
    (hp : ∀ h, ∑ j, p h j = 1) : ∑ j, mixture w p j = 1 := by

  simp only [mixture]
  rw [Finset.sum_comm]
  calc ∑ h, ∑ j, w h * p h j = ∑ h, w h := by
        refine Finset.sum_congr rfl fun h _ => ?_
        rw [← Finset.mul_sum, hp h, mul_one]
    _ = 1 := hw
