-- Generated from ChapterKernelBound.lean — solution of BookProof.KernelBound.kernel_row_bound
import Mathlib
import Definitions.Def_ChapterKernelBound
open BookProof.KernelBound




open Finset

variable {𝕜 : Type*} [RCLike 𝕜]
variable {ιx ιy : Type*} [Fintype ιx] [Fintype ιy]

variable {𝕜 : Type*} [RCLike 𝕜]
variable {ιx ιy : Type*} [Fintype ιx] [Fintype ιy]

set_option maxHeartbeats 1000000 in
theorem solution (Ψ : ιy → ιx → 𝕜) (Φ : ιx → 𝕜) (y : ιy) :
    ‖kernelOp Ψ Φ y‖ ^ 2 ≤ (∑ x, ‖Ψ y x‖ ^ 2) * (∑ x, ‖Φ x‖ ^ 2) := by

  -- By the properties of the inner product and the Cauchy-Schwarz inequality, we have:
  have h_inner : ‖∑ x, Ψ y x * Φ x‖ ^ 2 ≤ (∑ x, ‖Ψ y x‖ * ‖Φ x‖) ^ 2 := by
    exact pow_le_pow_left₀ ( norm_nonneg _ ) ( norm_sum_le _ _ |> le_trans <| Finset.sum_le_sum fun
        _ _ => by rw [ norm_mul ] ) _;
  refine le_trans h_inner ?_
  exact sum_mul_sq_le_sq_mul_sq univ (fun i ↦ ‖Ψ y i‖) fun i ↦ ‖Φ i‖
