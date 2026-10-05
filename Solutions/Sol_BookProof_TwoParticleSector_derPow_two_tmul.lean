-- Generated from ChapterTwoParticleSectorEsa.lean — solution of BookProof.TwoParticleSector.derPow_two_tmul
import Mathlib
import Definitions.Def_ChapterTwoParticleSectorEsa
open BookProof.TwoParticleSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]
variable {X}
variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (a b : D₂) (c : ℂ) :
    derPow Hs D₂ A 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = (A a) ⊗ₜ[ℂ] ((b : Hs.carrier) ⊗ₜ[ℂ] c)
        + (a : Hs.carrier) ⊗ₜ[ℂ] ((A b) ⊗ₜ[ℂ] c) := by

  have h1 : derPow Hs D₂ A 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = (A a) ⊗ₜ[ℂ] inclPow Hs D₂ 1 (b ⊗ₜ[ℂ] c)
        + (a : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c) := rfl
  have h2 : inclPow Hs D₂ 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
      = (b : Hs.carrier) ⊗ₜ[ℂ] c := rfl
  have h3 : derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
      = (A b) ⊗ₜ[ℂ] (c : (Hs.pow 0).carrier) := by
    have : derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
        = (A b) ⊗ₜ[ℂ] inclPow Hs D₂ 0 c
          + (b : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A 0 c := rfl
    rw [this, derPow_zero]
    simp [inclPow]
  rw [h1, h2, h3]
