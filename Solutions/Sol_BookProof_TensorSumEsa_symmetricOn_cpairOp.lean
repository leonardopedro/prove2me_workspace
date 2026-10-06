-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.symmetricOn_cpairOp
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_symmetricOn_pairOp
import Theorems.Thm_BookProof_GraphCore_symmetricOn_pushOp
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hA : SymmetricOn DA A) (hB : SymmetricOn DB B) :
    SymmetricOn (cpairDom Hs Ks DA DB) (cpairOp Hs Ks DA DB A B) :=
  symmetricOn_pushOp (pairEmb Hs Ks) (pairOp Hs Ks DA DB A B)
      (symmetricOn_pairOp Hs Ks DA DB A B hA hB)
