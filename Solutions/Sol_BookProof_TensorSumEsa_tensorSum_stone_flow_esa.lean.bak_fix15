-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.tensorSum_stone_flow_esa
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_symmetricOn_cpairOp
import Theorems.Thm_BookProof_TensorSumEsa_dense_cpairDom
import Theorems.Thm_BookProof_TensorSumEsa_essentiallySelfAdjointOn_cpairDom_esa
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
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
variable {Hs Ks : IPSpace}
variable [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]

set_option maxHeartbeats 1000000 in
theorem solution {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
    (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
    (hdenseA : Dense (DA : Set Hs.carrier)) (hdenseB : Dense (DB : Set Ks.carrier))
    (hsymA : SymmetricOn DA A) (hsymB : SymmetricOn DB B)
    (hesaA : EssentiallySelfAdjointOn DA A) (hesaB : EssentiallySelfAdjointOn DB B) :
    ∃ (G : UnboundedSelfAdjoint (ctensor Hs Ks))
      (U : ℝ → (ctensor Hs Ks →L[ℂ] ctensor Hs Ks)),
      IsSelfAdjointExtension (cpairOp Hs Ks DA DB A B) G.op ∧ IsStoneFlow G U :=
  exists_stone_flow_of_esa _ (dense_cpairDom Hs Ks DA DB hdenseA hdenseB)
      (symmetricOn_cpairOp Hs Ks DA DB A B hsymA hsymB)
      (essentiallySelfAdjointOn_cpairDom_esa A B hdenseA hdenseB hsymA hsymB hesaA hesaB)
