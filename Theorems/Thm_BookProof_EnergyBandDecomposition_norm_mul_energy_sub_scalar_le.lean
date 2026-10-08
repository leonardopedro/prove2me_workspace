-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.norm_mul_energy_sub_scalar_le
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition



open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}


theorem BookProof.EnergyBandDecomposition.norm_mul_energy_sub_scalar_le (hε : 0 < ε) (hx : x ∈ band E ε k) (z : ℂ) :
    ‖(E x : ℂ) * z - ((k : ℝ) * ε : ℝ) * z‖ ≤ ε * ‖z‖ := by sorry
