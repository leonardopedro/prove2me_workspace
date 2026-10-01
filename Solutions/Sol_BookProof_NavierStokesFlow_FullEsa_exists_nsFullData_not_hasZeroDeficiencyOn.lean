-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.exists_nsFullData_not_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_jacobiFullData_hamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_jacobiOp_not_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ d : NSFullData L2N, ¬ HasZeroDeficiencyOn d.D d.hamiltonian := by

  refine ⟨jacobiFullData, ?_⟩
  rw [jacobiFullData_hamiltonian]
  exact jacobiOp_not_hasZeroDeficiencyOn
