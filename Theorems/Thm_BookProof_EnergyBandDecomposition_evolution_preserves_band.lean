-- Generated from ChapterEnergyBandDecomposition.lean — theorem BookProof.EnergyBandDecomposition.evolution_preserves_band
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}



open MeasureTheory


theorem BookProof.EnergyBandDecomposition.evolution_preserves_band (t : ℝ) (f : X → ℂ) (k : ℤ) :
    Function.support (fun x => Complex.exp (-(Complex.I * (t * E x))) * bandPart E ε k f x)
      ⊆ band E ε k := by sorry
