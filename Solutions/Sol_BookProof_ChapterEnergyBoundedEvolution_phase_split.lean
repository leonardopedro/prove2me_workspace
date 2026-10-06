-- Generated from ChapterEnergyBoundedEvolution.lean — solution of BookProof.ChapterEnergyBoundedEvolution.phase_split
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution




open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {A B C z : ℂ} (h : A * B = C) : C * z - A * z = A * (B * z - z) := by

  rw [← h]; ring
