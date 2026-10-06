-- Generated from ChapterE3.lean — theorem BookProof.ChapterE3.euler_density_isIdempotent
import Mathlib
import Definitions.Def_ChapterE3
open BookProof.ChapterE3

variable {n : ℕ}


open scoped Matrix BigOperators



theorem BookProof.ChapterE3.euler_density_isIdempotent (l w : Fin n → ℝ) (θ : ℝ)
    (hll : ∑ i, l i * l i = 1) (hww : ∑ i, w i * w i = 1)
    (hlw : ∑ i, l i * w i = 0) :
    (Matrix.vecMulVec (fun i => Real.cos θ * l i + Real.sin θ * w i)
        (fun i => Real.cos θ * l i + Real.sin θ * w i))
      * (Matrix.vecMulVec (fun i => Real.cos θ * l i + Real.sin θ * w i)
        (fun i => Real.cos θ * l i + Real.sin θ * w i))
      = Matrix.vecMulVec (fun i => Real.cos θ * l i + Real.sin θ * w i)
        (fun i => Real.cos θ * l i + Real.sin θ * w i) := by sorry
