-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.density_collapse_generic
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity


open scoped Matrix
open Matrix


variable {d : ℕ}


theorem BookProof.ChapterEulerGenericDensity.density_collapse_generic (θ : ℝ) (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
        - (Real.sin (2 * θ) / 2) •
            ((Matrix.vecMulVec l l - Matrix.vecMulVec w w) * Jgen l w)
      = (Real.cos θ ^ 2) • Matrix.vecMulVec l l
        + (Real.sin θ ^ 2) • Matrix.vecMulVec w w := by sorry
