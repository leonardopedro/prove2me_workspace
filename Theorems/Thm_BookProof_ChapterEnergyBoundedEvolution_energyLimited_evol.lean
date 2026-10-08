-- Generated from ChapterEnergyBoundedEvolution.lean — theorem BookProof.ChapterEnergyBoundedEvolution.energyLimited_evol
import Definitions.Def_ChapterEnergyBandDecomposition
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution



open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}


theorem BookProof.ChapterEnergyBoundedEvolution.energyLimited_evol {Emax : ℝ} (t : ℝ) (h : EnergyLimited E μ Emax f) :
    EnergyLimited E μ Emax (evol E t f) := by sorry
