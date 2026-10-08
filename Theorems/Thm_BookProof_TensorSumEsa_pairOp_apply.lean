-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.pairOp_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TensorSumEsa



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

theorem BookProof.TensorSumEsa.pairOp_apply (x : pairDom Hs Ks DA DB) (x₀ : DA ⊗[ℂ] DB)
    (hx : (x : Hs.carrier ⊗[ℂ] Ks.carrier) = inclPair Hs Ks DA DB x₀) :
    pairOp Hs Ks DA DB A B x = sumPoly Hs Ks DA DB A B x₀ := by sorry
