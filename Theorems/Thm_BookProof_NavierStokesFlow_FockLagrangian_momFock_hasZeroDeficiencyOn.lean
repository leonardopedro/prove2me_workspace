-- Generated from ChapterNavierStokesFockParcels.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.momFock_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory



open FullEsa FockContinuum

theorem BookProof.NavierStokesFlow.FockLagrangian.momFock_hasZeroDeficiencyOn :
    HasZeroDeficiencyOn momFock.data.D momFock.data.hFull := by sorry
