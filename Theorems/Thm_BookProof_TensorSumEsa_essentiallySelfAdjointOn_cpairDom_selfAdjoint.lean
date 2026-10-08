-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairDom_selfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterTensorGraphCore
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.TensorCore
open BookProof.TensorSumEsa



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)
variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]

theorem BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairDom_selfAdjoint (T : UnboundedSelfAdjoint Hs.carrier)
    (S : UnboundedSelfAdjoint Ks.carrier) :
    EssentiallySelfAdjointOn (cpairDom Hs Ks T.domain S.domain)
      (cpairOp Hs Ks T.domain S.domain T.op S.op) := by sorry
