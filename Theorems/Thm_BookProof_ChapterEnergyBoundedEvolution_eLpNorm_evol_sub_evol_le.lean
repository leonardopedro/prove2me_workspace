-- Generated from ChapterEnergyBoundedEvolution.lean — theorem BookProof.ChapterEnergyBoundedEvolution.eLpNorm_evol_sub_evol_le
import Definitions.Def_ChapterEnergyBandDecomposition
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution



open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}


theorem BookProof.ChapterEnergyBoundedEvolution.eLpNorm_evol_sub_evol_le {Emax : ℝ} (h : EnergyLimited E μ Emax f) (s t : ℝ) :
    eLpNorm (evol E t f - evol E s f) 2 μ
      ≤ ENNReal.ofReal (|t - s| * Emax) * eLpNorm f 2 μ := by sorry
