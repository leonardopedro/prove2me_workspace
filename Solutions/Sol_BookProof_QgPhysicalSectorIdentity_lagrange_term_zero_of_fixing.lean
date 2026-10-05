-- Generated from ChapterQgPhysicalSectorIdentity.lean — solution of BookProof.QgPhysicalSectorIdentity.lagrange_term_zero_of_fixing
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
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
theorem solution
    (hfix : gaugeField S.toGaugeFixingSystem = S.toGaugeFixingSystem.zero (1, 0)) :
    S.mul (1, 0) (1, 0) S.B (gaugeField S.toGaugeFixingSystem) = S.zero (2, 0) := by

  rw [hfix]
  exact S.mul_zero_right S.B
