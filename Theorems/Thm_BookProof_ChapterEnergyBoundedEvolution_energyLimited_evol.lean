-- Generated from ChapterEnergyBoundedEvolution.lean — theorem BookProof.ChapterEnergyBoundedEvolution.energyLimited_evol
import Definitions.Def_ChapterEnergyBandDecomposition
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}



open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition


theorem BookProof.ChapterEnergyBoundedEvolution.energyLimited_evol {Emax : ℝ} (t : ℝ) (h : EnergyLimited E μ Emax f) :
    EnergyLimited E μ Emax (evol E t f) := by sorry
