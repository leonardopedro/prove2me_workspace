-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.measurableSet_band
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}



open MeasureTheory


theorem BookProof.EnergyBandDecomposition.measurableSet_band [MeasurableSpace X] (hE : Measurable E) (ε : ℝ) (k : ℤ) :
    MeasurableSet (band E ε k) := by sorry
