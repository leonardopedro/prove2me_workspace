-- Generated from ChapterE3.lean — theorem BookProof.ChapterE3.euler_density_matrix
import Mathlib
import Definitions.Def_ChapterE3
open BookProof.ChapterE3


open scoped Matrix BigOperators


variable {n : ℕ}


theorem BookProof.ChapterE3.euler_density_matrix (l w : Fin n → ℝ) (θ : ℝ) :
    Matrix.vecMulVec (fun i => Real.cos θ * l i + Real.sin θ * w i)
        (fun i => Real.cos θ * l i + Real.sin θ * w i)
      = (1 / 2 : ℝ) • (Matrix.vecMulVec l l + Matrix.vecMulVec w w)
        + (Real.cos (2 * θ) / 2) • (Matrix.vecMulVec l l - Matrix.vecMulVec w w)
        + (Real.sin (2 * θ) / 2) • (Matrix.vecMulVec l w + Matrix.vecMulVec w l) := by sorry
