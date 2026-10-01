-- Generated from ChapterNavierStokesFullEsa.lean — theorem BookProof.NavierStokesFlow.FullEsa.latticeFullData_hamiltonian_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (d : NSFullData F)


open scoped ENNReal

theorem BookProof.NavierStokesFlow.FullEsa.latticeFullData_hamiltonian_apply (v : Fin 15 → LinfZ) (nu : ℝ)
    (x : (latticeFullData v nu).D) :
    ((latticeFullData v nu).hamiltonian x : L2Z) = latticeFullHamiltonianCLM v nu (x : L2Z) := by sorry
