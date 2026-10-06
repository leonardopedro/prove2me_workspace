-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.density_euler_generic
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity

variable {d : ℕ}


open scoped Matrix
open Matrix



theorem BookProof.ChapterEulerGenericDensity.density_euler_generic (θ : ℝ) (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
      = (1 / 2 : ℝ) • (Matrix.vecMulVec l l + Matrix.vecMulVec w w)
        + (Real.cos (2 * θ) / 2) • (Matrix.vecMulVec l l - Matrix.vecMulVec w w)
        + (Real.sin (2 * θ) / 2) •
            ((Matrix.vecMulVec l l - Matrix.vecMulVec w w) * Jgen l w) := by sorry
