-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.density_symm
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity

variable {d : ℕ}


open scoped Matrix
open Matrix



theorem BookProof.ChapterEulerGenericDensity.density_symm (θ : ℝ) (l w : Fin d → ℝ) :
    (Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w))ᵀ
      = Matrix.vecMulVec (eulerVec θ l w) (eulerVec θ l w) := by sorry
