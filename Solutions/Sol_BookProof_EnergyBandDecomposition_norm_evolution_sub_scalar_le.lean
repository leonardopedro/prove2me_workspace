-- Generated from ChapterEnergyBandDecomposition.lean — solution of BookProof.EnergyBandDecomposition.norm_evolution_sub_scalar_le
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
import Theorems.Thm_BookProof_EnergyBandDecomposition_energy_sub_scalar_lt
import Theorems.Thm_BookProof_EnergyBandDecomposition_norm_evolution_sub_scalar_le'
open BookProof.EnergyBandDecomposition




open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

set_option maxHeartbeats 1000000 in
theorem solution (hε : 0 < ε) (hx : x ∈ band E ε k) (t : ℝ) (z : ℂ) :
    ‖Complex.exp (-(Complex.I * (t * (E x : ℂ)))) * z
        - Complex.exp (-(Complex.I * (t * ((((k : ℝ) * ε : ℝ)) : ℂ)))) * z‖ ≤ |t| * ε * ‖z‖ := norm_evolution_sub_scalar_le' t ((k : ℝ) * ε) z (energy_sub_scalar_lt hε hx).le
