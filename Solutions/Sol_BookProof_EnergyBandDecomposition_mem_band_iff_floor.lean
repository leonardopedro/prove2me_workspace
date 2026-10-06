-- Generated from ChapterEnergyBandDecomposition.lean — solution of BookProof.EnergyBandDecomposition.mem_band_iff_floor
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition




open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

set_option maxHeartbeats 1000000 in
theorem solution (hε : 0 < ε) (E : X → ℝ) (k : ℤ) (x : X) :
    x ∈ band E ε k ↔ k = ⌊E x / ε⌋ := by

  have h : x ∈ band E ε k ↔ (k : ℝ) ≤ E x / ε ∧ E x / ε < k + 1 := by
    simp only [band, Set.mem_preimage, Set.mem_Ico]
    rw [le_div_iff₀ hε, div_lt_iff₀ hε]
  rw [h, eq_comm, Int.floor_eq_iff]
