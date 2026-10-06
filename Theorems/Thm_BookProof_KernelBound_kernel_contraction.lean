-- Generated from ChapterKernelBound.lean — theorem BookProof.KernelBound.kernel_contraction
import Mathlib
import Definitions.Def_ChapterKernelBound
open BookProof.KernelBound

variable {𝕜 : Type*} [RCLike 𝕜]
variable {ιx ιy : Type*} [Fintype ιx] [Fintype ιy]



open Finset


theorem BookProof.KernelBound.kernel_contraction (Ψ : ιy → ιx → 𝕜) (Φ : ιx → 𝕜)
    (hΨ : ∑ y, ∑ x, ‖Ψ y x‖ ^ 2 = 1) :
    ∑ y, ‖kernelOp Ψ Φ y‖ ^ 2 ≤ ∑ x, ‖Φ x‖ ^ 2 := by sorry
