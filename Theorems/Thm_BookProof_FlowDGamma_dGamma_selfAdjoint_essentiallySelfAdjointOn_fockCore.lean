-- Generated from ChapterFlowDGammaEsa.lean — theorem BookProof.FlowDGamma.dGamma_selfAdjoint_essentiallySelfAdjointOn_fockCore
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterFlowDGammaEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterTensorGraphCore
open BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.TensorCore
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

theorem BookProof.FlowDGamma.dGamma_selfAdjoint_essentiallySelfAdjointOn_fockCore
    (T : UnboundedSelfAdjoint Hs.carrier) (D : Submodule ℂ Hs.carrier)
    (hcore : IsGraphCore D T.op) :
    EssentiallySelfAdjointOn (dsCore (fun n : ℕ => fockSectorCore Hs T.domain D n))
      (dGammaCoreOp Hs T.domain T.op D) := by sorry
