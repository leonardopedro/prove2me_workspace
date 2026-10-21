-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairCore_selfAdjoint
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_essentiallySelfAdjointOn_cpairDom_selfAdjoint
import Theorems.Thm_BookProof_TensorSumEsa_essentiallySelfAdjointOn_cpairCore
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

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint Hs.carrier)
    (S : UnboundedSelfAdjoint Ks.carrier) (CA : Submodule ℂ Hs.carrier)
    (CB : Submodule ℂ Ks.carrier) (hcoreA : IsGraphCore CA T.op)
    (hcoreB : IsGraphCore CB S.op) :
    EssentiallySelfAdjointOn (cpairCore Hs Ks T.domain S.domain CA CB)
      (restrictOp (cpairOp Hs Ks T.domain S.domain T.op S.op)
        (cpairCore_le_cpairDom Hs Ks T.domain S.domain CA CB)) :=
  essentiallySelfAdjointOn_cpairCore Hs Ks T.domain S.domain T.op S.op CA CB hcoreA hcoreB
      (essentiallySelfAdjointOn_cpairDom_selfAdjoint T S)
