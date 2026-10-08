-- Generated from ChapterEnergyBoundedEvolution.lean — theorem BookProof.ChapterEnergyBoundedEvolution.norm_evol_sub_evol_le_ae
import Definitions.Def_ChapterEnergyBandDecomposition
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution



open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}


theorem BookProof.ChapterEnergyBoundedEvolution.norm_evol_sub_evol_le_ae {Emax : ℝ} (h : EnergyLimited E μ Emax f) (s t : ℝ) :
    ∀ᵐ x ∂μ, ‖evol E t f x - evol E s f x‖ ≤ (|t - s| * Emax) * ‖f x‖ := by sorry
