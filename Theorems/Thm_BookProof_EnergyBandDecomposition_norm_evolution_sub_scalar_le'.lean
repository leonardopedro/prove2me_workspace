-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.norm_evolution_sub_scalar_le'
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition



open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}


theorem BookProof.EnergyBandDecomposition.norm_evolution_sub_scalar_le_prime {a : ℝ} (t c : ℝ) (z : ℂ) (h : |a - c| ≤ ε) :
    ‖Complex.exp (-(Complex.I * (t * a))) * z
        - Complex.exp (-(Complex.I * (t * c))) * z‖ ≤ |t| * ε * ‖z‖ := by sorry
