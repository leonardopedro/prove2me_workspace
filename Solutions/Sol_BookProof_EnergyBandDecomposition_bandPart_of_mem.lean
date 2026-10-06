-- Generated from ChapterEnergyBandDecomposition.lean — solution of BookProof.EnergyBandDecomposition.bandPart_of_mem
import Mathlib
import Definitions.Def_ChapterEnergyBandDecomposition
open BookProof.EnergyBandDecomposition




open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

set_option maxHeartbeats 1000000 in
theorem solution (hx : x ∈ band E ε k) (f : X → ℂ) :
    bandPart E ε k f x = f x := Set.indicator_of_mem hx f
