-- Generated from ChapterEnergyBoundedEvolution.lean — theorem BookProof.ChapterEnergyBoundedEvolution.eLpNorm_difference_quotient_le
import Definitions.Def_ChapterEnergyBandDecomposition
import Mathlib
import Definitions.Def_ChapterEnergyBoundedEvolution
open BookProof.ChapterEnergyBoundedEvolution



open MeasureTheory Complex
open scoped ENNReal
open BookProof.EnergyBandDecomposition

variable {X : Type*} [MeasurableSpace X] {μ : Measure X} {E : X → ℝ} {f : X → ℂ}


theorem BookProof.ChapterEnergyBoundedEvolution.eLpNorm_difference_quotient_le {Emax : ℝ} (h : EnergyLimited E μ Emax f) {t : ℝ}
    (ht : t ≠ 0) :
    eLpNorm (fun x => (evol E t f x - f x) / t) 2 μ ≤ ENNReal.ofReal Emax * eLpNorm f 2 μ := by sorry
