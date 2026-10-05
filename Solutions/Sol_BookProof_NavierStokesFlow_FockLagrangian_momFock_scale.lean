-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.momFock_scale
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution (c : ParcelConf ℝ) :
    momFock.scale c = 3 * |∑ k : Fin c.1, c.2 k| := by
  simp only [LagSymbols.scale, momFock, fockLagSymbols, secondQuant, Fin.sum_univ_three]
  simp
  ring

/-- The total symbol of this realization is the (total) kinetic energy. -/
theorem momFock_total (c : ParcelConf ℝ) :
    momFock.total c = (3 / 2) * (∑ k : Fin c.1, c.2 k) ^ 2 := by

  simp only [LagSymbols.scale, momFock, fockLagSymbols, secondQuant, Fin.sum_univ_three]
  simp
  ring
