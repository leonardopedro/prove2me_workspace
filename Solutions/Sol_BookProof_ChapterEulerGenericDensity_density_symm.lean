-- Generated from ChapterEulerGenericDensity.lean — solution of BookProof.ChapterEulerGenericDensity.density_symm
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity



open scoped Matrix
open Matrix


variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) (l w : Fin d → ℝ) :
    (Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w))ᵀ
      = Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w) := by

  ext i j; simp [Matrix.vecMulVec_apply, Matrix.transpose_apply, mul_comm]
