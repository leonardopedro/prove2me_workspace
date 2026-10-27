-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.continuityHamiltonian_hasZeroDeficiencyOn_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_hasZeroDeficiencyOn_of_bounded_symmetric
import Theorems.Thm_BookProof_NavierStokesFlow_continuityHamiltonian_mem_finiteModes
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_continuityHamiltonian_isSymmetric
import Theorems.Thm_BookProof_NavierStokesFlow_finiteModes_dense
open BookProof.NavierStokesFlow



open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (v : LinfZ) :
    HasZeroDeficiencyOn finiteModes
      (LinearMap.codRestrict finiteModes
        ((continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).comp finiteModes.subtype)
        fun f => continuityHamiltonian_mem_finiteModes v f.2) :=
        ((continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).comp finiteModes.subtype)
          fun f => continuityHamiltonian_mem_finiteModes v f.2) :=
    hasZeroDeficiencyOn_of_bounded_symmetric (continuity
