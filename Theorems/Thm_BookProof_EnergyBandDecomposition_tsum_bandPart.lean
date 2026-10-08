-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.tsum_bandPart
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition



open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}


theorem BookProof.EnergyBandDecomposition.tsum_bandPart (hε : 0 < ε) (f : X → ℂ) (x : X) :
    ∑' k : ℤ, bandPart E ε k f x = f x := by sorry
