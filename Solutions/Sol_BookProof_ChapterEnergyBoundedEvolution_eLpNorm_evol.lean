-- Generated from ChapterEnergyBoundedEvolution.lean — solution of BookProof.ChapterEnergyBoundedEvolution.eLpNorm_evol
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
import Theorems.Thm_BookProof_ChapterEnergyBoundedEvolution_norm_evol_apply
open BookProof.ChapterEnergyBoundedEvolution




open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (f : X → ℂ) (p : ℝ≥0∞) :
    eLpNorm (evol E t f) p μ = eLpNorm f p μ := by

  refine eLpNorm_congr_norm_ae ?_
  exact Filter.Eventually.of_forall fun x => norm_evol_apply t f x
