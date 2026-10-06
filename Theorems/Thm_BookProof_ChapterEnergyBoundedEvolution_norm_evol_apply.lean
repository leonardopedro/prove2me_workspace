-- Generated from ChapterEnergyBoundedEvolution.lean — theorem BookProof.ChapterEnergyBoundedEvolution.norm_evol_apply
import Definitions.Def_ChapterEnergyBandDecomposition
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}



open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition


theorem BookProof.ChapterEnergyBoundedEvolution.norm_evol_apply (t : ℝ) (f : X → ℂ) (x : X) : ‖evol E t f x‖ = ‖f x‖ := by sorry
