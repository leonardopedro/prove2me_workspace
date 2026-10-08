-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.norm_evolution_sub_scalar_le
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition



open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}


theorem BookProof.EnergyBandDecomposition.norm_evolution_sub_scalar_le (hε : 0 < ε) (hx : x ∈ band E ε k) (t : ℝ) (z : ℂ) :
    ‖Complex.exp (-(Complex.I * (t * (E x : ℂ)))) * z
        - Complex.exp (-(Complex.I * (t * ((((k : ℝ) * ε : ℝ)) : ℂ)))) * z‖ ≤ |t| * ε * ‖z‖ := by sorry
