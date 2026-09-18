-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.ns_esa_of_farisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.NavierStokesFlow.ns_esa_of_farisLavine (H N : F →ₗ[ℂ] F) (c₁ c₂ : ℝ) (hsym : H.IsSymmetric)
    (farisLavine : ∀ (H' N' : F →ₗ[ℂ] F) (a b : ℝ), H'.IsSymmetric →
      (∀ v : F, ‖H' v‖ ≤ a * ‖N' v‖) →
      (∀ v : F, ‖(inner ℂ v (H' (N' v) - N' (H' v)) : ℂ)‖ ≤ b * ‖(inner ℂ v (N' v) : ℂ)‖) →
      HasZeroDeficiency H')
    (hHbound : ∀ v : F, ‖H v‖ ≤ c₁ * ‖N v‖)
    (hCommutator : ∀ v : F,
      ‖(inner ℂ v (H (N v) - N (H v)) : ℂ)‖ ≤ c₂ * ‖(inner ℂ v (N v) : ℂ)‖) :
    HasZeroDeficiency H := by sorry
