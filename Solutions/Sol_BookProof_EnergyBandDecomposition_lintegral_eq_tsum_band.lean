-- Generated from ChapterEnergyBandDecomposition.lean — solution of BookProof.EnergyBandDecomposition.lintegral_eq_tsum_band
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
import Theorems.Thm_BookProof_EnergyBandDecomposition_measurableSet_band
import Theorems.Thm_BookProof_EnergyBandDecomposition_band_pairwise_disjoint
import Theorems.Thm_BookProof_EnergyBandDecomposition_iUnion_band
open BookProof.EnergyBandDecomposition




open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

set_option maxHeartbeats 1000000 in
theorem solution [MeasurableSpace X] {μ : Measure X} (hε : 0 < ε)
    (hE : Measurable E)
    (f : X → ℂ) :
    ∫⁻ x, ‖f x‖ₑ ^ 2 ∂μ = ∑' k : ℤ, ∫⁻ x in band E ε k, ‖f x‖ₑ ^ 2 ∂μ := by

  have hdisj : Pairwise (Function.onFun Disjoint (band E ε)) := band_pairwise_disjoint hε E
  have hmeas : ∀ k : ℤ, MeasurableSet (band E ε k) := fun k => measurableSet_band hE ε k
  rw [← lintegral_iUnion hmeas hdisj, iUnion_band hε E, Measure.restrict_univ]
