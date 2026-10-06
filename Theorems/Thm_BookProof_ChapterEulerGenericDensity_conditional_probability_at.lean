-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.conditional_probability_at
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity

variable {d : ℕ}


open scoped Matrix
open Matrix



theorem BookProof.ChapterEulerGenericDensity.conditional_probability_at (θ : ℝ) (l w : Fin d → ℝ)
    (k : Fin d) (hlk : l k = 1) (hwk : w k = 0) :
    ((Real.cos θ ^ 2) • Matrix.vecMulVec l l
      + (Real.sin θ ^ 2) • Matrix.vecMulVec w w) k k = Real.cos θ ^ 2 := by sorry
