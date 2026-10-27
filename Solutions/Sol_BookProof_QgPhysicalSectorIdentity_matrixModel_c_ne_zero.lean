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
-- `Qm_ne_zero`/`matrixModel_c_ne_zero` are leaf-dropped from the published
-- Def_ChapterGaugeFixing bundle: inlined verbatim from the source chapter.
private theorem Qm_ne_zero : BookProof.GaugeFixing.Qm ≠ 0 := by
  intro h
  have h01 : BookProof.GaugeFixing.Qm 0 1 = (0 : Mat2) 0 1 := by rw [h]
  simp [BookProof.GaugeFixing.Qm] at h01

private theorem gaugeMatrixModel_c_ne_zero : (BookProof.GaugeFixing.matrixModel.c : Mat2) ≠ 0 := by
  simpa [BookProof.GaugeFixing.matrixModel] using Qm_ne_zero

theorem solution : (BookProof.QgPhysicalSectorIdentity.matrixModel.c : Mat2) ≠ 0 := by

  change (BookProof.GaugeFixing.matrixModel.c : Mat2) ≠ 0
  exact gaugeMatrixModel_c_ne_zero
