-- Generated from ChapterQgPhysicalSectorIdentity.lean — solution of BookProof.QgPhysicalSectorIdentity.L_gf_constraint_surface
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Theorems.Thm_BookProof_QgPhysicalSectorIdentity_lagrange_term_zero_of_fixing
import Theorems.Thm_BookProof_GaugeFixing_L_gf_evaluation
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
    S.s (Psi S.toGaugeFixingSystem) =
      S.sub (2, 0) (S.zero (2, 0)) (S.mul (1, -1) (1, 1) S.c_bar S.c) := by

  rw [L_gf_evaluation (S := S.toGaugeFixingSystem), lagrange_term_zero_of_fixing S hfix]
