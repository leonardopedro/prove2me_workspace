-- Generated from ChapterFlowDGammaEsa.lean — solution of BookProof.FlowDGamma.position_not_bounded
import Mathlib
import Definitions.Def_ChapterFlowDGammaEsa
import Theorems.Thm_BookProof_ChapterStoneSeparable_mulSA_position_unbounded
open BookProof.FlowDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (E₁ E₂ : Type) [NormedAddCommGroup E₁] [InnerProductSpace ℂ E₁]
  [NormedAddCommGroup E₂] [InnerProductSpace ℂ E₂]
variable {E₁ E₂}
variable {Hs : IPSpace} {D₂ : Submodule ℂ Hs.carrier} {A : D₂ →ₗ[ℂ] Hs.carrier}
variable (P : OneParticleFlow Hs D₂ A)
variable {Hs : IPSpace} [CompleteSpace Hs.carrier]

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ x : (mulSA positionField).domain,
      ‖(mulSA positionField).op x‖ ≤ C * ‖(x : BookProof.ChapterContinuityUnitaryInfinite.L2Z)‖ := mulSA_position_unbounded
