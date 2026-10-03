-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.driSym_meas
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.driSym_meas : Measurable S.driSym := by sorry
