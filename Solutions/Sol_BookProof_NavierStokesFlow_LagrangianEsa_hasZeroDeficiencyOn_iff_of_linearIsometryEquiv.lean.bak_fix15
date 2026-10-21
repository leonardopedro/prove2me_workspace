-- Generated from ChapterNavierStokesLagrangianEsa.lean — solution of BookProof.NavierStokesFlow.LagrangianEsa.hasZeroDeficiencyOn_iff_of_linearIsometryEquiv
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_hasZeroDeficiencyOn_of_linearIsometryEquiv
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianEsa_hasZeroDeficiencyOn_map_of_linearIsometryEquiv
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianEsa





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution (W : F ≃ₗᵢ[ℂ] G) {D : Submodule ℂ F}
    {D' : Submodule ℂ G} {H : D →ₗ[ℂ] D} {H' : D' →ₗ[ℂ] D'}
    (hmap : ∀ x : D, W (x : F) ∈ D') (hsurj : ∀ y : D', ∃ x : D, W (x : F) = (y : G))
    (hint : ∀ x : D, (H' ⟨W (x : F), hmap x⟩ : G) = W ((H x : F))) :
    HasZeroDeficiencyOn D H ↔ HasZeroDeficiencyOn D' H' :=
  ⟨hasZeroDeficiencyOn_map_of_linearIsometryEquiv W hmap hint,
      hasZeroDeficiencyOn_of_linearIsometryEquiv W hmap hsurj hint⟩
