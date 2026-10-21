-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.NSFullData.advection_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_IsSymmetricDom_sub
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_IsSymmetricDom_sum
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_IsSymmetricDom_comp_of_commute
import Theorems.Thm_BookProof_YangMillsHermite_PolySym_real_smul
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa.NSFullData



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable (d : NSFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) : IsSymmetricDom (d.advection i) :=
  ((IsSymmetricDom.sum Finset.univ fun _ _ =>
        (d.u_symm _).comp_of_commute (d.u_symm _) (d.u_comm _ _)).sub
      ((d.u_symm _).real_smul d.nu))
