-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.latticeFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_hasZeroDeficiencyOn_of_boundedRealization
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_NSFullData_hasZeroDeficiencyOn_of_boundedRealization
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_latticeFullHamiltonianCLM_isSymmetric
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_latticeFullData_hamiltonian_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 15 → LinfZ) (nu : ℝ) :
    HasZeroDeficiencyOn (latticeFullData v nu).D (latticeFullData v nu).hamiltonian :=
  (latticeFullData v nu).hasZeroDeficiencyOn_of_boundedRealization
      (latticeFullHamiltonianCLM v nu) (latticeFullHamiltonianCLM_isSymmetric v nu)
      (latticeFullData_hamiltonian_apply v nu)
