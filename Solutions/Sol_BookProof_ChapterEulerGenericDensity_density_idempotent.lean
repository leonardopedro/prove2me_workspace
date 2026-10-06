-- Generated from ChapterEulerGenericDensity.lean — solution of BookProof.ChapterEulerGenericDensity.density_idempotent
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
import Theorems.Thm_BookProof_ChapterEulerGenericDensity_vecMulVec_mul_vecMulVec
import Theorems.Thm_BookProof_ChapterEulerGenericDensity_eulerVec_unit
open BookProof.ChapterEulerGenericDensity



open scoped Matrix
open Matrix


variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
        * Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
      = Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w) := by

  rw [vecMulVec_mul_vecMulVec, eulerVec_unit θ l w hll hww hlw, one_smul]
