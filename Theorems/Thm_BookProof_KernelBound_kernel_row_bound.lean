-- Generated from ChapterKernelBound.lean — theorem BookProof.KernelBound.kernel_row_bound
import Mathlib
import Definitions.Def_ChapterKernelBound
open BookProof.KernelBound



open Finset

variable {𝕜 : Type*} [RCLike 𝕜]
variable {ιx ιy : Type*} [Fintype ιx] [Fintype ιy]


theorem BookProof.KernelBound.kernel_row_bound (Ψ : ιy → ιx → 𝕜) (Φ : ιx → 𝕜) (y : ιy) :
    ‖kernelOp Ψ Φ y‖ ^ 2 ≤ (∑ x, ‖Ψ y x‖ ^ 2) * (∑ x, ‖Φ x‖ ^ 2) := by sorry
