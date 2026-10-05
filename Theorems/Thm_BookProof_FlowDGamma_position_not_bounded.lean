-- Generated from ChapterFlowDGammaEsa.lean — theorem BookProof.FlowDGamma.position_not_bounded
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Mathlib
import Definitions.Def_ChapterFlowDGammaEsa
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition
open BookProof.FlowDGamma

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (E₁ E₂ : Type) [NormedAddCommGroup E₁] [InnerProductSpace ℂ E₁]
  [NormedAddCommGroup E₂] [InnerProductSpace ℂ E₂]
variable {E₁ E₂}
variable {Hs : IPSpace} {D₂ : Submodule ℂ Hs.carrier} {A : D₂ →ₗ[ℂ] Hs.carrier}
variable (P : OneParticleFlow Hs D₂ A)
variable {Hs : IPSpace} [CompleteSpace Hs.carrier]



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.FlowDGamma.position_not_bounded :
    ¬ ∃ C : ℝ, ∀ x : (mulSA positionField).domain,
      ‖(mulSA positionField).op x‖ ≤ C * ‖(x : BookProof.ChapterContinuityUnitaryInfinite.L2Z)‖ := by sorry
