-- Generated from ChapterNavierStokesFockParcels.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.momFock_total
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian



open MeasureTheory



open FullEsa FockContinuum
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow.ThreeComponent

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution (c : ParcelConf ℝ) :
    momFock.total c = (3 / 2) * (∑ k : Fin c.1, c.2 k) ^ 2 := by

  simp only [LagSymbols.total, momFock, fockLagSymbols, secondQuant, Fin.sum_univ_three]
  simp
  ring
