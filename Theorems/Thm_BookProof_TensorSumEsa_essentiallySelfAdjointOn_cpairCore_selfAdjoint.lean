-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairCore_selfAdjoint
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterTensorGraphCore
open BookProof.GraphCore
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
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
  (CA : Submodule ℂ Hs.carrier) (CB : Submodule ℂ Ks.carrier)

theorem BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairCore_selfAdjoint (T : UnboundedSelfAdjoint Hs.carrier)
    (S : UnboundedSelfAdjoint Ks.carrier) (CA : Submodule ℂ Hs.carrier)
    (CB : Submodule ℂ Ks.carrier) (hcoreA : IsGraphCore CA T.op)
    (hcoreB : IsGraphCore CB S.op) :
    EssentiallySelfAdjointOn (cpairCore Hs Ks T.domain S.domain CA CB)
      (restrictOp (cpairOp Hs Ks T.domain S.domain T.op S.op)
        (cpairCore_le_cpairDom Hs Ks T.domain S.domain CA CB)) := by sorry
