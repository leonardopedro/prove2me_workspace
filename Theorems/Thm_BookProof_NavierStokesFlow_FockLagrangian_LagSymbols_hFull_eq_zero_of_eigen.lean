-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.hFull_eq_zero_of_eigen
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.hFull_eq_zero_of_eigen {lam : ℂ} (hlevel : μ {x | (S.total x : ℂ) = lam} = 0)
    (v : S.core) (hv : ((S.data.hFull v : S.core) : Lp ℂ 2 μ) = lam • ((v : Lp ℂ 2 μ))) :
    ((v : Lp ℂ 2 μ)) = 0 := by sorry
