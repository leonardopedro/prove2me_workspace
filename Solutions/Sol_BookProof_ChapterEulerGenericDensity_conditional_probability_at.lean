-- Generated from ChapterEulerGenericDensity.lean — solution of BookProof.ChapterEulerGenericDensity.conditional_probability_at
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity



open scoped Matrix
open Matrix


variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) (l w : Fin d → ℝ)
    (k : Fin d) (hlk : l k = 1) (hwk : w k = 0) :
    ((Real.cos θ ^ 2) • Matrix.vecMulVec l l
      + (Real.sin θ ^ 2) • Matrix.vecMulVec w w) k k = Real.cos θ ^ 2 := by

  simp [Matrix.vecMulVec_apply, smul_eq_mul, hlk, hwk]
