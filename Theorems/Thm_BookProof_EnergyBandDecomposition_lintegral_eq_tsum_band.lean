-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.lintegral_eq_tsum_band
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition



open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}


theorem BookProof.EnergyBandDecomposition.lintegral_eq_tsum_band [MeasurableSpace X] {μ : Measure X} (hε : 0 < ε)
    (hE : Measurable E)
    (f : X → ℂ) :
    ∫⁻ x, ‖f x‖ₑ ^ 2 ∂μ = ∑' k : ℤ, ∫⁻ x in band E ε k, ‖f x‖ₑ ^ 2 ∂μ := by sorry
