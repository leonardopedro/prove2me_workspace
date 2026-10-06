-- Generated from ChapterNavierStokesLagrangianEsa.lean — theorem BookProof.NavierStokesFlow.LagrangianEsa.NSFullData.hasZeroDeficiencyOn_of_lagrangian
import Mathlib
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.NavierStokesFlow

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (L : LagrangianFullData F)
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]




open FullEsa

theorem BookProof.NavierStokesFlow.LagrangianEsa.NSFullData.hasZeroDeficiencyOn_of_lagrangian (d : FullEsa.NSFullData F)
    (L : LagrangianFullData G) (W : F ≃ₗᵢ[ℂ] G) (hmap : ∀ x : d.D, W (x : F) ∈ L.D)
    (hsurj : ∀ y : L.D, ∃ x : d.D, W (x : F) = (y : G))
    (hint : ∀ x : d.D, (L.hFull ⟨W (x : F), hmap x⟩ : G) = W ((d.hamiltonian x : F)))
    (hL : HasZeroDeficiencyOn L.D L.hFull) :
    HasZeroDeficiencyOn d.D d.hamiltonian := by sorry
