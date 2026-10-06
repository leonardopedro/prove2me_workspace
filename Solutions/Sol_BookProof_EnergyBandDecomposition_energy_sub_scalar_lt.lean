-- Generated from ChapterEnergyBandDecomposition.lean — solution of BookProof.EnergyBandDecomposition.energy_sub_scalar_lt
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition




open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

set_option maxHeartbeats 1000000 in
theorem solution (hε : 0 < ε) (hx : x ∈ band E ε k) :
    |E x - k * ε| < ε := by

  obtain ⟨h1, h2⟩ := hx
  rw [abs_lt]
  constructor
  · linarith
  · nlinarith [h2]
