-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.ns_esa_of_farisLavine_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.ns_esa_of_farisLavine_dense (D : Submodule ℂ F) (H N : D →ₗ[ℂ] D) (c₁ c₂ : ℝ)
    (farisLavine : ∀ (D' : Submodule ℂ F) (H' N' : D' →ₗ[ℂ] D') (a b : ℝ),
      Dense (D' : Set F) →
      (∀ x y : D', (inner ℂ (H' x : F) (y : F) : ℂ) = inner ℂ (x : F) (H' y : F)) →
      (∀ v : D', ‖(H' v : F)‖ ≤ a * ‖(N' v : F)‖) →
      (∀ v : D', ‖(inner ℂ (v : F) ((H' (N' v) : F) - (N' (H' v) : F)) : ℂ)‖
        ≤ b * ‖(inner ℂ (v : F) (N' v : F) : ℂ)‖) →
      HasZeroDeficiencyOn D' H')
    (hdense : Dense (D : Set F))
    (hsym : ∀ x y : D, (inner ℂ (H x : F) (y : F) : ℂ) = inner ℂ (x : F) (H y : F))
    (hHbound : ∀ v : D, ‖(H v : F)‖ ≤ c₁ * ‖(N v : F)‖)
    (hCommutator : ∀ v : D, ‖(inner ℂ (v : F) ((H (N v) : F) - (N (H v) : F)) : ℂ)‖
      ≤ c₂ * ‖(inner ℂ (v : F) (N v : F) : ℂ)‖) :
    HasZeroDeficiencyOn D H := by sorry
