-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.diagFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagFullData_hamiltonian
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin 15 → ℕ → ℝ) (p : Fin 3 → ℕ → ℝ) (nu : ℝ) :
    HasZeroDeficiencyOn (diagFullData c p nu).D (diagFullData c p nu).hamiltonian := by

  rw [diagFullData_hamiltonian]
  exact diagOp_hasZeroDeficiencyOn _
