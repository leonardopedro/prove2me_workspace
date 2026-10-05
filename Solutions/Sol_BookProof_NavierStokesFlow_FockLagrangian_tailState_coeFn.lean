-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.tailState_coeFn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution :
    ((tailState : Lp ℂ 2 fockR) : ParcelConf ℝ → ℂ)
      =ᵐ[fockR] tailFockSet.indicator (fun _ => (1 : ℂ)) := MemLp.coeFn_toLp _
