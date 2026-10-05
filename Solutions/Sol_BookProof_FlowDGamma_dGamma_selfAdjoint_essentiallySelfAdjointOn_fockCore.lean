-- Generated from ChapterFlowDGammaEsa.lean — solution of BookProof.FlowDGamma.dGamma_selfAdjoint_essentiallySelfAdjointOn_fockCore
import Mathlib
import Definitions.Def_ChapterFlowDGammaEsa
import Theorems.Thm_BookProof_FlowDGamma_OneParticleFlow_dGamma_flow_essentiallySelfAdjointOn_fockCore
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
theorem solution
    (T : UnboundedSelfAdjoint Hs.carrier) (D : Submodule ℂ Hs.carrier)
    (hcore : IsGraphCore D T.op) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs T.domain D n))
      (dGammaCoreOp Hs T.domain T.op D) :=
  OneParticleFlow.dGamma_flow_essentiallySelfAdjointOn_fockCore (ofSelfAdjoint T)
      T.denseDomain D hcore
