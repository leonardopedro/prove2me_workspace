-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.cpairOp_apply
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Theorems.Thm_BookProof_TensorSumEsa_pairOp_apply
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (x : cpairDom Hs Ks DA DB) (x₀ : DA ⊗[ℂ] DB)
    (hx : (x : ctensor Hs Ks) = pairEmb Hs Ks (inclPair Hs Ks DA DB x₀)) :
    cpairOp Hs Ks DA DB A B x = pairEmb Hs Ks (sumPoly Hs Ks DA DB A B x₀) := by

  have hmem : inclPair Hs Ks DA DB x₀ ∈ pairDom Hs Ks DA DB := ⟨x₀, rfl⟩
  have h1 : cpairOp Hs Ks DA DB A B x
      = pairEmb Hs Ks (pairOp Hs Ks DA DB A B ⟨inclPair Hs Ks DA DB x₀, hmem⟩) :=
    pushOp_apply (pairEmb Hs Ks) (pairOp Hs Ks DA DB A B) x ⟨inclPair Hs Ks DA DB x₀, hmem⟩ hx
  rw [h1, pairOp_apply Hs Ks DA DB A B ⟨inclPair Hs Ks DA DB x₀, hmem⟩ x₀ rfl]
