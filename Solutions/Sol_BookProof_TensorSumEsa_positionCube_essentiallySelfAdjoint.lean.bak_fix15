-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.positionCube_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_essentiallySelfAdjointOn_cpairDom_selfAdjoint
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
theorem solution :
    EssentiallySelfAdjointOn
      (cpairDom L2ZSpace L2ZSpace (mulSA positionField).domain (mulSA cubeField).domain)
      (cpairOp L2ZSpace L2ZSpace (mulSA positionField).domain (mulSA cubeField).domain
        (mulSA positionField).op (mulSA cubeField).op) :=
  essentiallySelfAdjointOn_cpairDom_selfAdjoint (Hs := L2ZSpace) (Ks := L2ZSpace)
      (mulSA positionField) (mulSA cubeField)
