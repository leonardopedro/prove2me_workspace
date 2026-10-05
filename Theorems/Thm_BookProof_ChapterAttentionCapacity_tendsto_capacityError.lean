-- Generated from ChapterAttentionCapacity.lean — theorem BookProof.ChapterAttentionCapacity.tendsto_capacityError
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCapacity
open BookProof.ChapterAttentionCapacity

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionCapacity.tendsto_capacityError {r C : ℝ} (hr : 0 < r) (M : ℝ) :
    Tendsto (fun b : ℝ => 2 * C * (M * Real.exp (-(b * r ^ 2)))) atTop (𝓝 0) := by sorry
