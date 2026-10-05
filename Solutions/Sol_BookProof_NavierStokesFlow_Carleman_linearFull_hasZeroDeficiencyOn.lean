-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.linearFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_halfLineFull_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_linearFullData_symbol
import Theorems.Thm_BookProof_NavierStokesFlow_Carleman_not_summable_nsCoupling_linear
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution :
    HasZeroDeficiencyOn linearFullData.D linearFullData.hamiltonian := by

  refine halfLineFull_hasZeroDeficiencyOn linearMode 1 ?_
  rw [linearFullData_symbol]
  exact not_summable_nsCoupling_linear
