-- Generated from ChapterFlowDGammaEsa.lean — solution of BookProof.FlowDGamma.OneParticleFlow.dGamma_flow_essentiallySelfAdjointOn_fockCore
import Mathlib
import Definitions.Def_ChapterFlowDGammaEsa
import Theorems.Thm_BookProof_SecondQuantizationCore_dGamma_essentiallySelfAdjointOn_fockCore
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

set_option maxHeartbeats 1000000 in
theorem solution (hdense : Dense (D₂ : Set Hs.carrier))
    (D : Submodule ℂ Hs.carrier) (hcore : IsGraphCore D A) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs D₂ D n))
      (dGammaCoreOp Hs D₂ A D) :=
  dGamma_essentiallySelfAdjointOn_fockCore Hs D₂ A D hcore
      (essentiallySelfAdjointOn_fockSectorDom_flow P hdense)
