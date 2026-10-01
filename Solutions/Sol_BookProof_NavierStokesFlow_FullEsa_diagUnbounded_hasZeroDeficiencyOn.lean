-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.diagUnbounded_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_diagFull_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    HasZeroDeficiencyOn diagUnboundedData.D diagUnboundedData.hamiltonian := diagFull_hasZeroDeficiencyOn _ _ _
