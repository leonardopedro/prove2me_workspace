-- Generated from ChapterEnergyBoundedEvolution.lean — theorem BookProof.ChapterEnergyBoundedEvolution.eLpNorm_evol_sub_self_le
import Definitions.Def_ChapterEnergyBandDecomposition
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}



open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition


theorem BookProof.ChapterEnergyBoundedEvolution.eLpNorm_evol_sub_self_le {Emax : ℝ} (h : EnergyLimited E μ Emax f) (t : ℝ) :
    eLpNorm (evol E t f - f) 2 μ ≤ ENNReal.ofReal (|t| * Emax) * eLpNorm f 2 μ := by sorry
