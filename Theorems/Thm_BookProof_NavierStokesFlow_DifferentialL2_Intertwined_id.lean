-- Generated from ChapterNavierStokesDifferentialL2.lean — theorem BookProof.NavierStokesFlow.DifferentialL2.Intertwined.id
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2.Intertwined

variable {d : ℕ}
variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

') :
    Intertwined (T.comp S) (T'.comp S') := fun x => by
  simp only [LinearMap.comp_apply, hS x, hT (S x)]

theorem BookProof.NavierStokesFlow.DifferentialL2.Intertwined.id : Intertwined LinearMap.id LinearMap.id := fun _ => rfl

theorem Intertwined.sum {ι : Type*} (s : Finset ι)
    {T : ι → lpFiniteModes Vel →ₗ[ℂ] lpFiniteMode := by sorry
