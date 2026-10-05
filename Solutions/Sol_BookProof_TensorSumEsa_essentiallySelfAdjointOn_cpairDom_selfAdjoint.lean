-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.essentiallySelfAdjointOn_cpairDom_selfAdjoint
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_essentiallySelfAdjointOn_cpairDom_flow
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

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint Hs.carrier)
    (S : UnboundedSelfAdjoint Ks.carrier) :
    EssentiallySelfAdjointOn (cpairDom Hs Ks T.domain S.domain)
      (cpairOp Hs Ks T.domain S.domain T.op S.op) :=
  essentiallySelfAdjointOn_cpairDom_flow (ofSelfAdjoint T) (ofSelfAdjoint S) T.denseDomain
      S.denseDomain
