-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.halfLineFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_tridiag_hasZeroDeficiencyOn_of_carleman
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_halfLineFullData_hamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin 15 → ℕ → ℝ) (nu : ℝ)
    (hcar : ¬ Summable fun n => 1 / ‖nsCoupling (halfLineSymbol c nu) n‖) :
    HasZeroDeficiencyOn (halfLineFullData c nu).D (halfLineFullData c nu).hamiltonian := by

  rw [halfLineFullData_hamiltonian]
  exact tridiag_hasZeroDeficiencyOn_of_carleman _ hcar
