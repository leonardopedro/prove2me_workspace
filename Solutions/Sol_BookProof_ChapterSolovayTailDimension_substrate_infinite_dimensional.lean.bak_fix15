-- Generated from ChapterSolovayTailDimension.lean — solution of BookProof.ChapterSolovayTailDimension.substrate_infinite_dimensional
import Mathlib
import Definitions.Def_ChapterSolovayTailDimension
import Theorems.Thm_BookProof_ChapterSolovayTailDimension_substrateBasisVector_orthonormal
open BookProof.ChapterSolovayTailDimension



noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : ¬ FiniteDimensional ℝ Substrate := by

  intro _
  haveI : Finite ℕ :=
    (substrateBasisVector_orthonormal.linearIndependent).finite_of_isNoetherian
  exact not_finite ℕ
