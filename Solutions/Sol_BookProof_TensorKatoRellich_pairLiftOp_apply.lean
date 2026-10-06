-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.pairLiftOp_apply
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Theorems.Thm_BookProof_TensorKatoRellich_pairLiftDom_apply
import Theorems.Thm_BookProof_GraphCore_pushOp_apply
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (L : (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier))
    (x : cpairDom Hs Ks DA DB) (x₀ : DA ⊗[ℂ] DB)
    (hx : (x : ctensor Hs Ks) = pairEmb Hs Ks (inclPair Hs Ks DA DB x₀)) :
    pairLiftOp Hs Ks DA DB L x = pairEmb Hs Ks (L x₀) := by

  have hmem : inclPair Hs Ks DA DB x₀ ∈ pairDom Hs Ks DA DB := ⟨x₀, rfl⟩
  have h1 : pairLiftOp Hs Ks DA DB L x
      = pairEmb Hs Ks (pairLiftDom Hs Ks DA DB L ⟨inclPair Hs Ks DA DB x₀, hmem⟩) :=
    pushOp_apply (pairEmb Hs Ks) (pairLiftDom Hs Ks DA DB L) x ⟨inclPair Hs Ks DA DB x₀, hmem⟩ hx
  rw [h1, pairLiftDom_apply Hs Ks DA DB L ⟨inclPair Hs Ks DA DB x₀, hmem⟩ x₀ rfl]
