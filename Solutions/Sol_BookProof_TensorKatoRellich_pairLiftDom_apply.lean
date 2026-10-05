-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.pairLiftDom_apply
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (L : (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier))
    (x : pairDom Hs Ks DA DB) (x₀ : DA ⊗[ℂ] DB)
    (hx : (x : Hs.carrier ⊗[ℂ] Ks.carrier) = inclPair Hs Ks DA DB x₀) :
    pairLiftDom Hs Ks DA DB L x = L x₀ := by

  have hxx : (LinearEquiv.ofInjective (inclPair Hs Ks DA DB).toLinearMap
      (fun _ _ h => (inclPair Hs Ks DA DB).injective h)) x₀ = x := by
    apply Subtype.ext; rw [hx]; rfl
  have h2 : (LinearEquiv.ofInjective (inclPair Hs Ks DA DB).toLinearMap
      (fun _ _ h => (inclPair Hs Ks DA DB).injective h)).symm x = x₀ := by
    rw [← hxx]; simp
  exact congrArg (fun z => L z) h2
