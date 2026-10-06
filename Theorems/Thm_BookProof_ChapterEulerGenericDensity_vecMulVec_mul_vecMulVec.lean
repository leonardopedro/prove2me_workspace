-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.vecMulVec_mul_vecMulVec
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity

variable {d : ℕ}


open scoped Matrix
open Matrix



theorem BookProof.ChapterEulerGenericDensity.vecMulVec_mul_vecMulVec (u v x y : Fin d → ℝ) :
    Matrix.vecMulVec u v * Matrix.vecMulVec x y = (v ⬝ᵥ x) • Matrix.vecMulVec u y := by sorry
