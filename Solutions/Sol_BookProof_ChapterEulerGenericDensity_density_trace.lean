-- Generated from ChapterEulerGenericDensity.lean — solution of BookProof.ChapterEulerGenericDensity.density_trace
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
import Theorems.Thm_BookProof_ChapterEulerGenericDensity_eulerVec_unit
open BookProof.ChapterEulerGenericDensity



open scoped Matrix
open Matrix


variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    Matrix.trace (Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)) = 1 := by

  rw [show (1 : ℝ) = eulerVec θ l w ⬝ᵥ eulerVec θ l w
      from (eulerVec_unit θ l w hll hww hlw).symm]
  simp [Matrix.trace, Matrix.diag, Matrix.vecMulVec_apply, dotProduct]
