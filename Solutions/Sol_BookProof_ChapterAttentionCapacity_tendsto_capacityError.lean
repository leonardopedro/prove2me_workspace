-- Generated from ChapterAttentionCapacity.lean — solution of BookProof.ChapterAttentionCapacity.tendsto_capacityError
import Mathlib
import Definitions.Def_ChapterAttentionCapacity
open BookProof.ChapterAttentionCapacity



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {r C : ℝ} (hr : 0 < r) (M : ℝ) :
    Tendsto (fun b : ℝ => 2 * C * (M * Real.exp (-(b * r ^ 2)))) atTop (𝓝 0) := by

  have hr2 : 0 < r ^ 2 := by positivity
  have hlin : Tendsto (fun b : ℝ => -(b * r ^ 2)) atTop atBot := by
    have h1 : Tendsto (fun b : ℝ => b * r ^ 2) atTop atTop :=
      Filter.Tendsto.atTop_mul_const hr2 tendsto_id
    exact tendsto_neg_atTop_atBot.comp h1
  have hexp : Tendsto (fun b : ℝ => Real.exp (-(b * r ^ 2))) atTop (𝓝 0) :=
    Real.tendsto_exp_atBot.comp hlin
  have := ((hexp.const_mul M).const_mul (2 * C))
  simpa using this
