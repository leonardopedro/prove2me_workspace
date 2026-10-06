-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.band_pairwise_disjoint
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}



open MeasureTheory


theorem BookProof.EnergyBandDecomposition.band_pairwise_disjoint (hε : 0 < ε) (E : X → ℝ) :
    Pairwise (Function.onFun Disjoint (band E ε)) := by sorry
