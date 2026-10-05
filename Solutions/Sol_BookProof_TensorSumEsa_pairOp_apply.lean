-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.pairOp_apply
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (x : pairDom Hs Ks DA DB) (x₀ : DA ⊗[ℂ] DB)
    (hx : (x : Hs.carrier ⊗[ℂ] Ks.carrier) = inclPair Hs Ks DA DB x₀) :
    pairOp Hs Ks DA DB A B x = sumPoly Hs Ks DA DB A B x₀ := by

  have hxx : (LinearEquiv.ofInjective (inclPair Hs Ks DA DB).toLinearMap
      (inclPair Hs Ks DA DB).injective) x₀ = x := by
    apply Subtype.ext; rw [hx]; rfl
  have h2 : (LinearEquiv.ofInjective (inclPair Hs Ks DA DB).toLinearMap
      (inclPair Hs Ks DA DB).injective).symm x = x₀ := by
    rw [← hxx]; simp
  exact congrArg (fun z => sumPoly Hs Ks DA DB A B z) h2
