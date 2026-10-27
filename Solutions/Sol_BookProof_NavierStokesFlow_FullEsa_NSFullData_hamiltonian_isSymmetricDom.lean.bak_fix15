-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.NSFullData.hamiltonian_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_IsSymmetricDom_sum
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_IsSymmetricDom_anticomm
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_NSFullData_advection_isSymmetricDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa.NSFullData



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable (d : NSFullData F)

set_option maxHeartbeats 1000000 in
theorem solution : IsSymmetricDom d.hamiltonian :=
  IsSymmetricDom.sum Finset.univ fun i _ =>
      (d.mom_symm i).anticomm (d.advection_isSymmetricDom i)
