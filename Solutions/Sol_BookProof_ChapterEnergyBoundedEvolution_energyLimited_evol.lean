-- Generated from ChapterEnergyBoundedEvolution.lean — solution of BookProof.ChapterEnergyBoundedEvolution.energyLimited_evol
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution




open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {Emax : ℝ} (t : ℝ) (h : EnergyLimited E μ Emax f) :
    EnergyLimited E μ Emax (evol E t f) := by

  filter_upwards [h] with x hx hne
  refine hx fun hf => hne ?_
  simp [evol, hf]
