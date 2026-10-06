-- Generated from ChapterKernelBound.lean — theorem BookProof.KernelBound.kernel_l2_bound
import Mathlib
import Definitions.Def_ChapterKernelBound
open BookProof.KernelBound

variable {𝕜 : Type*} [RCLike 𝕜]
variable {ιx ιy : Type*} [Fintype ιx] [Fintype ιy]



open Finset


theorem BookProof.KernelBound.kernel_l2_bound (Ψ : ιy → ιx → 𝕜) (Φ : ιx → 𝕜) :
    Real.sqrt (∑ y, ‖kernelOp Ψ Φ y‖ ^ 2)
      ≤ Real.sqrt (∑ y, ∑ x, ‖Ψ y x‖ ^ 2) * Real.sqrt (∑ x, ‖Φ x‖ ^ 2) := by sorry
