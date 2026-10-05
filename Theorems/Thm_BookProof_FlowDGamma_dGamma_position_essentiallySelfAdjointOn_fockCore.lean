-- Generated from ChapterFlowDGammaEsa.lean — theorem BookProof.FlowDGamma.dGamma_position_essentiallySelfAdjointOn_fockCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Mathlib
import Definitions.Def_ChapterFlowDGammaEsa
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.DirectSumEsa
open BookProof.GraphCore
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

theorem BookProof.FlowDGamma.dGamma_position_essentiallySelfAdjointOn_fockCore
    (D : Submodule ℂ L2ZSpace.carrier)
    (hcore : IsGraphCore D (mulSA positionField).op) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore L2ZSpace (mulSA positionField).domain D n))
      (dGammaCoreOp L2ZSpace (mulSA positionField).domain (mulSA positionField).op D) := by sorry
