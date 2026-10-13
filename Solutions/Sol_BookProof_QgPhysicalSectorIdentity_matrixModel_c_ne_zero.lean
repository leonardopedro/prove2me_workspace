-- Generated from ChapterQgPhysicalSectorIdentity.lean — solution of BookProof.QgPhysicalSectorIdentity.matrixModel_c_ne_zero
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterGaugeFixing
open BookProof.QgPhysicalSectorIdentity




open BookProof.GaugeFixing
open BookProof.FockQuadratic
open BookProof.OperatorSeries
open BookProof.FarisLavine
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal

variable {F : BiDegree → Type} (S : DerivativeVariableFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : (matrixModel.c : Mat2) ≠ 0 := by

  change (BookProof.GaugeFixing.matrixModel.c : Mat2) ≠ 0
  exact BookProof.GaugeFixing.matrixModel_c_ne_zero
