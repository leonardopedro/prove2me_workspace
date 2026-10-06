-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.bandPart_of_not_mem
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}



open MeasureTheory


theorem BookProof.EnergyBandDecomposition.bandPart_of_not_mem (hx : x ∉ band E ε k) (f : X → ℂ) :
    bandPart E ε k f x = 0 := by sorry
