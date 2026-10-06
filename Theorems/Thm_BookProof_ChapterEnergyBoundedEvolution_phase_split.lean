-- Generated from ChapterEnergyBoundedEvolution.lean — theorem BookProof.ChapterEnergyBoundedEvolution.phase_split
import Definitions.Def_ChapterEnergyBandDecomposition
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}



open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition


theorem BookProof.ChapterEnergyBoundedEvolution.phase_split {A B C z : ℂ} (h : A * B = C) : C * z - A * z = A * (B * z - z) := by sorry
