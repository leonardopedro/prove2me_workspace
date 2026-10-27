-- Generated from ChapterFlowDGammaEsa.lean — solution of BookProof.FlowDGamma.dGamma_position_essentiallySelfAdjointOn_fockCore
import Mathlib
import Definitions.Def_ChapterFlowDGammaEsa
import Theorems.Thm_BookProof_FlowDGamma_dGamma_selfAdjoint_essentiallySelfAdjointOn_fockCore
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
    (D : Submodule ℂ L2ZSpace.carrier)
    (hcore : IsGraphCore D (mulSA positionField).op) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore L2ZSpace (mulSA positionField).domain D n))
      (dGammaCoreOp L2ZSpace (mulSA positionField).domain (mulSA positionField).op D) :=
  dGamma_selfAdjoint_essentiallySelfAdjointOn_fockCore (Hs := L2ZSpace) (mulSA positionField)
      D hcore
