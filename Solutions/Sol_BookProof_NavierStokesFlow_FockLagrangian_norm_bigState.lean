-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.norm_bigState
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution (K : ℝ) : ‖bigState K‖ = 1 := by

  rw [bigState, Lp.norm_toLp,
    eLpNorm_indicator_const (bigSet_measurable K) (by norm_num) (by norm_num),
    fockMeasure_bigSet]
  simp
