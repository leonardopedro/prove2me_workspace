-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.hFull_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_total_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_total_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_hFull_eq_mulD
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution :
    HasZeroDeficiencyOn S.data.D S.data.hFull := by

  rw [hFull_eq_mulD]
  exact mulD_hasZeroDeficiencyOn μ S.scale_meas S.total_meas S.total_dom
