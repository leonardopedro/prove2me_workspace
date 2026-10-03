-- Generated from ChapterNavierStokesFockLagrangian.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.kinetic_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterF7
open BookProof.NavierStokesFlow
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.NavierStokesFlow

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)


open MeasureTheory



open FullEsa FockContinuum


theorem BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.kinetic_eq : S.data.kinetic = mulD μ S.kinSym_meas S.kinSym_dom := by sorry
