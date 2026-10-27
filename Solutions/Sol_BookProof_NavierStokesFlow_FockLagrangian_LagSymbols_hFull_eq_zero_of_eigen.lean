-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.hFull_eq_zero_of_eigen
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.FockLagrangian

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution {lam : ℂ} (hlevel : μ {x | (S.total x : ℂ) = lam} = 0)
    (v : S.core) (hv : ((S.data.hFull v : S.core) : Lp ℂ 2 μ) = lam • ((v : Lp ℂ 2 μ))) :
    ((v : Lp ℂ 2 μ)) = 0 := by

  rw [S.hFull_eq_mulD] at hv
  exact mulD_eq_zero_of_eigen μ S.total_meas S.total_dom hlevel v hv
