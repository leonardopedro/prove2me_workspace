-- Generated from ChapterEulerGenericDensity.lean — solution of BookProof.ChapterEulerGenericDensity.density_euler_generic
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
import Theorems.Thm_BookProof_ChapterEulerGenericDensity_outer_eulerVec
import Theorems.Thm_BookProof_ChapterEulerGenericDensity_Jgen_mul
open BookProof.ChapterEulerGenericDensity



open scoped Matrix
open Matrix


variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
      = (1 / 2 : ℝ) • (Matrix.vecMulVec l l + Matrix.vecMulVec w w)
        + (Real.cos (2 * θ) / 2) • (Matrix.vecMulVec l l - Matrix.vecMulVec w w)
        + (Real.sin (2 * θ) / 2) •
            ((Matrix.vecMulVec l l - Matrix.vecMulVec w w) * Jgen l w) := by

  rw [Jgen_mul l w hll hww hlw, outer_eulerVec]
  ext i j
  simp only [Matrix.add_apply, Matrix.smul_apply, Matrix.sub_apply, Matrix.vecMulVec_apply,
    smul_eq_mul]
  rw [Real.cos_two_mul, Real.sin_two_mul]
  linear_combination (w i * w j) * Real.sin_sq_add_cos_sq θ
