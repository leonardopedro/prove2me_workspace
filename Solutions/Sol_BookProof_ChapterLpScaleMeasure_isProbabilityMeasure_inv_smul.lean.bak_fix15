-- Generated from ChapterLpScaleMeasure.lean — solution of BookProof.ChapterLpScaleMeasure.isProbabilityMeasure_inv_smul
import Mathlib
import Definitions.Def_ChapterLpScaleMeasure
open BookProof.ChapterLpScaleMeasure



noncomputable section

open MeasureTheory ENNReal


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

variable {α : Type*} [MeasurableSpace α] {nu : Measure α} {c : ENNReal}

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure nu] (hne : nu Set.univ ≠ 0) :
    IsProbabilityMeasure ((nu Set.univ)⁻¹ • nu) := by

  constructor
  rw [Measure.smul_apply, smul_eq_mul]
  exact ENNReal.inv_mul_cancel hne (measure_ne_top nu _)
