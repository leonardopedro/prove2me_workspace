-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.sumPoly_symm
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TensorSumEsa



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

theorem BookProof.TensorSumEsa.sumPoly_symm (hA : SymmetricOn DA A) (hB : SymmetricOn DB B) :
    ∀ x y : DA ⊗[ℂ] DB,
      (inner ℂ (sumPoly Hs Ks DA DB A B x) (inclPair Hs Ks DA DB y) : ℂ)
        = inner ℂ (inclPair Hs Ks DA DB x) (sumPoly Hs Ks DA DB A B y) := by sorry
