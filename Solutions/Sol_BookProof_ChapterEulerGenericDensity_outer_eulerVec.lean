-- Generated from ChapterEulerGenericDensity.lean — solution of BookProof.ChapterEulerGenericDensity.outer_eulerVec
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity



open scoped Matrix
open Matrix


variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) (l w : Fin d → ℝ) :
    Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
      = (Real.cos θ ^ 2) • Matrix.vecMulVec l l
        + (Real.sin θ ^ 2) • Matrix.vecMulVec w w
        + (Real.cos θ * Real.sin θ) •
            (Matrix.vecMulVec l w + Matrix.vecMulVec w l) := by

  ext i j
  simp only [eulerVec, Matrix.vecMulVec_apply, Pi.add_apply, Pi.smul_apply, smul_eq_mul,
    Matrix.add_apply, Matrix.smul_apply]
  ring
