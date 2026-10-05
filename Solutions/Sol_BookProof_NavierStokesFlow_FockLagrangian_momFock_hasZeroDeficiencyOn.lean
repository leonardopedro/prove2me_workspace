-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.momFock_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_hFull_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution :
    HasZeroDeficiencyOn momFock.data.D momFock.data.hFull := momFock.hFull_hasZeroDeficiencyOn
