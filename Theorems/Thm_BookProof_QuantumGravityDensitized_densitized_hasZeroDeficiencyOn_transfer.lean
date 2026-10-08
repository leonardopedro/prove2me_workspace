-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.densitized_hasZeroDeficiencyOn_transfer
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.QuantumGravityDensitized



open Filter Topology BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

theorem BookProof.QuantumGravityDensitized.densitized_hasZeroDeficiencyOn_transfer (W : F ≃ₗᵢ[ℂ] G) {D : Submodule ℂ F}
    {D' : Submodule ℂ G} {H : D →ₗ[ℂ] D} {H' : D' →ₗ[ℂ] D'}
    (hmap : ∀ x : D, W (x : F) ∈ D') (hsurj : ∀ y : D', ∃ x : D, W (x : F) = (y : G))
    (hint : ∀ x : D, (H' ⟨W (x : F), hmap x⟩ : G) = W ((H x : F)))
    (hflat : HasZeroDeficiencyOn D' H') : HasZeroDeficiencyOn D H := by sorry
