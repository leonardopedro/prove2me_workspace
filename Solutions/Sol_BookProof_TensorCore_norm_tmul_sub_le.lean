-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.norm_tmul_sub_le
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution {E F : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [NormedAddCommGroup F] [InnerProductSpace ℂ F] (x x' : E) (y y' : F) :
    ‖x ⊗ₜ[ℂ] y - x' ⊗ₜ[ℂ] y'‖ ≤ ‖x - x'‖ * ‖y‖ + ‖x'‖ * ‖y - y'‖ := by

  have hid : x ⊗ₜ[ℂ] y - x' ⊗ₜ[ℂ] y' = (x - x') ⊗ₜ[ℂ] y + x' ⊗ₜ[ℂ] (y - y') := by
    rw [TensorProduct.sub_tmul, TensorProduct.tmul_sub]; abel
  rw [hid]
  refine le_trans (norm_add_le _ _) ?_
  simp [TensorProduct.norm_tmul]
