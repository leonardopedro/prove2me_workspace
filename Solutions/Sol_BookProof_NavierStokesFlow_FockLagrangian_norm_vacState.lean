-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.norm_vacState
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution : ‖vacState‖ = 1 := by

  rw [vacState, Lp.norm_toLp,
    eLpNorm_indicator_const vacSet_measurable (by norm_num) (by norm_num), fockMeasure_vacSet]
  simp
