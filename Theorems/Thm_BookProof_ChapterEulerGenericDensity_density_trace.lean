-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.density_trace
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity

variable {d : ℕ}


open scoped Matrix
open Matrix



theorem BookProof.ChapterEulerGenericDensity.density_trace (θ : ℝ) (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    Matrix.trace (Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w)) = 1 := by sorry
