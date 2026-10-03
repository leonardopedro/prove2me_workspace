-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.drift_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.drift_eq : S.data.drift = mulD μ S.driSym_meas S.driSym_dom := by sorry
