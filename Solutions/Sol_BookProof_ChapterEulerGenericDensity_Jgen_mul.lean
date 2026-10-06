-- Generated from ChapterEulerGenericDensity.lean — solution of BookProof.ChapterEulerGenericDensity.Jgen_mul
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
import Theorems.Thm_BookProof_ChapterEulerGenericDensity_vecMulVec_mul_vecMulVec
open BookProof.ChapterEulerGenericDensity



open scoped Matrix
open Matrix


variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    (Matrix.vecMulVec l l - Matrix.vecMulVec w w) * Jgen l w
      = Matrix.vecMulVec l w + Matrix.vecMulVec w l := by

  have hwl : w ⬝ᵥ l = 0 := by rw [dotProduct_comm]; exact hlw
  simp only [Jgen, sub_mul, mul_sub, vecMulVec_mul_vecMulVec, hll, hww, hlw, hwl,
    one_smul, zero_smul]
  abel
