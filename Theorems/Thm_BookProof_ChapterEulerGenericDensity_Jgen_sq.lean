-- Generated from ChapterEulerGenericDensity.lean — theorem BookProof.ChapterEulerGenericDensity.Jgen_sq
import Mathlib
import Definitions.Def_ChapterEulerGenericDensity
open BookProof.ChapterEulerGenericDensity

variable {d : ℕ}


open scoped Matrix
open Matrix



theorem BookProof.ChapterEulerGenericDensity.Jgen_sq (l w : Fin d → ℝ)
    (hll : l ⬝ᵥ l = 1) (hww : w ⬝ᵥ w = 1) (hlw : l ⬝ᵥ w = 0) :
    Jgen l w * Jgen l w = -(Matrix.vecMulVec l l + Matrix.vecMulVec w w) := by sorry
