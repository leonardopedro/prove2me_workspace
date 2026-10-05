-- Generated from ChapterQgPhysicalSectorIdentity.lean — solution of BookProof.QgPhysicalSectorIdentity.s_gaugeField_eq_c
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Theorems.Thm_BookProof_GaugeFixing_s_gaugeField
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
theorem solution : S.s (gaugeField S.toGaugeFixingSystem) = S.c := by

  exact s_gaugeField (S := S.toGaugeFixingSystem)
