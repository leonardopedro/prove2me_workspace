-- Generated from ChapterKernelBound.lean — solution of BookProof.KernelBound.kernel_contraction
import Mathlib
import Definitions.Def_ChapterKernelBound
import Theorems.Thm_BookProof_KernelBound_kernel_hs_sq_bound
open BookProof.KernelBound




open Finset

variable {𝕜 : Type*} [RCLike 𝕜]
variable {ιx ιy : Type*} [Fintype ιx] [Fintype ιy]

variable {𝕜 : Type*} [RCLike 𝕜]
variable {ιx ιy : Type*} [Fintype ιx] [Fintype ιy]

set_option maxHeartbeats 1000000 in
theorem solution (Ψ : ιy → ιx → 𝕜) (Φ : ιx → 𝕜)
    (hΨ : ∑ y, ∑ x, ‖Ψ y x‖ ^ 2 = 1) :
    ∑ y, ‖kernelOp Ψ Φ y‖ ^ 2 ≤ ∑ x, ‖Φ x‖ ^ 2 := by

  simpa [ hΨ ] using kernel_hs_sq_bound Ψ Φ
