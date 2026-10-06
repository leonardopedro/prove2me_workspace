-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.iUnion_band
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}



open MeasureTheory


theorem BookProof.EnergyBandDecomposition.iUnion_band (hε : 0 < ε) (E : X → ℝ) : (⋃ k : ℤ, band E ε k) = Set.univ := by sorry
