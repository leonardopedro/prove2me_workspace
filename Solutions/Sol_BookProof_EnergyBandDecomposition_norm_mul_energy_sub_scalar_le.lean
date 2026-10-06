-- Generated from ChapterEnergyBandDecomposition.lean — solution of BookProof.EnergyBandDecomposition.norm_mul_energy_sub_scalar_le
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
import Theorems.Thm_BookProof_EnergyBandDecomposition_energy_sub_scalar_lt
open BookProof.EnergyBandDecomposition




open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

set_option maxHeartbeats 1000000 in
theorem solution (hε : 0 < ε) (hx : x ∈ band E ε k) (z : ℂ) :
    ‖(E x : ℂ) * z - ((k : ℝ) * ε : ℝ) * z‖ ≤ ε * ‖z‖ := by

  have h : ((E x : ℂ) * z - (((k : ℝ) * ε : ℝ) : ℂ) * z) = ((E x - k * ε : ℝ) : ℂ) * z := by
    push_cast
    ring
  rw [h, norm_mul, Complex.norm_real, Real.norm_eq_abs]
  exact mul_le_mul_of_nonneg_right (energy_sub_scalar_lt hε hx).le (norm_nonneg z)
