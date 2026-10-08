-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.outer_eulerVec
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity


open scoped Matrix
open Matrix


variable {d : ℕ}


theorem BookProof.ChapterEulerGenericDensity.outer_eulerVec (θ : ℝ) (l w : Fin d → ℝ) :
    Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
      = (Real.cos θ ^ 2) • Matrix.vecMulVec l l
        + (Real.sin θ ^ 2) • Matrix.vecMulVec w w
        + (Real.cos θ * Real.sin θ) •
            (Matrix.vecMulVec l w + Matrix.vecMulVec w l) := by sorry
