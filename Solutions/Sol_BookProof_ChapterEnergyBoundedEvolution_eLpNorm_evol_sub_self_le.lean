-- Generated from ChapterEnergyBoundedEvolution.lean — solution of BookProof.ChapterEnergyBoundedEvolution.eLpNorm_evol_sub_self_le
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
import Theorems.Thm_BookProof_ChapterEnergyBoundedEvolution_eLpNorm_evol_sub_evol_le
open BookProof.ChapterEnergyBoundedEvolution




open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {Emax : ℝ} (h : EnergyLimited E μ Emax f) (t : ℝ) :
    eLpNorm (evol E t f - f) 2 μ ≤ ENNReal.ofReal (|t| * Emax) * eLpNorm f 2 μ := by

  have := eLpNorm_evol_sub_evol_le h 0 t
  simpa using this
