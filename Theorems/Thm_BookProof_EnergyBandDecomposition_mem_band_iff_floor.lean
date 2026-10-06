-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.mem_band_iff_floor
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}



open MeasureTheory


theorem BookProof.EnergyBandDecomposition.mem_band_iff_floor (hε : 0 < ε) (E : X → ℝ) (k : ℤ) (x : X) :
    x ∈ band E ε k ↔ k = ⌊E x / ε⌋ := by sorry
