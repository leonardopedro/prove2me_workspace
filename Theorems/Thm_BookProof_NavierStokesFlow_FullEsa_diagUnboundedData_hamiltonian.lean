-- Generated from ChapterNavierStokesFullEsa.lean — theorem BookProof.NavierStokesFlow.FullEsa.diagUnboundedData_hamiltonian
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

theorem BookProof.NavierStokesFlow.FullEsa.diagUnboundedData_hamiltonian :
    diagUnboundedData.hamiltonian = diagOp (fun n => -(2 * (n : ℝ))) := by sorry
