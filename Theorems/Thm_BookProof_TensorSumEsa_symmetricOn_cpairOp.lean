-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.symmetricOn_cpairOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TensorSumEsa

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.TensorSumEsa.symmetricOn_cpairOp (hA : SymmetricOn DA A) (hB : SymmetricOn DB B) :
    SymmetricOn (cpairDom Hs Ks DA DB) (cpairOp Hs Ks DA DB A B) := by sorry
