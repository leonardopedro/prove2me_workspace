-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.density_idempotent
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity


open scoped Matrix
open Matrix


variable {d : ℕ}


theorem BookProof.ChapterEulerGenericDensity.density_idempotent (θ : ℝ) (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
        * Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)
      = Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w) := by sorry
