-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.densitized_hasZeroDeficiencyOn_transfer
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_hasZeroDeficiencyOn_of_linearIsometryEquiv
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution (W : F ≃ₗᵢ[ℂ] G) {D : Submodule ℂ F}
    {D' : Submodule ℂ G} {H : D →ₗ[ℂ] D} {H' : D' →ₗ[ℂ] D'}
    (hmap : ∀ x : D, W (x : F) ∈ D') (hsurj : ∀ y : D', ∃ x : D, W (x : F) = (y : G))
    (hint : ∀ x : D, (H' ⟨W (x : F), hmap x⟩ : G) = W ((H x : F)))
    (hflat : HasZeroDeficiencyOn D' H') : HasZeroDeficiencyOn D H := hasZeroDeficiencyOn_of_linearIsometryEquiv W hmap hsurj hint hflat
