-- Generated from ChapterE3.lean — theorem BookProof.ChapterE3.euler_density_diag_real
import Mathlib
import Definitions.Def_ChapterE3
open BookProof.ChapterE3


open scoped Matrix BigOperators


variable {n : ℕ}


theorem BookProof.ChapterE3.euler_density_diag_real (l w : Fin n → ℝ) (θ : ℝ) (i : Fin n)
    (hli : l i = 1) (hwi : w i = 0) :
    Matrix.vecMulVec (fun j => Real.cos θ * l j + Real.sin θ * w j)
        (fun j => Real.cos θ * l j + Real.sin θ * w j) i i
      = Real.cos θ ^ 2 := by sorry
