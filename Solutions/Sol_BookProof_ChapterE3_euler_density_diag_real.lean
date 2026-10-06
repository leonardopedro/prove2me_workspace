-- Generated from ChapterE3.lean — solution of BookProof.ChapterE3.euler_density_diag_real
import Mathlib
import Definitions.Def_ChapterE3
open BookProof.ChapterE3



open scoped Matrix BigOperators


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l w : Fin n → ℝ) (θ : ℝ) (i : Fin n)
    (hli : l i = 1) (hwi : w i = 0) :
    Matrix.vecMulVec (fun j => Real.cos θ * l j + Real.sin θ * w j)
        (fun j => Real.cos θ * l j + Real.sin θ * w j) i i
      = Real.cos θ ^ 2 := by

  simp [ Matrix.vecMulVec, hli, hwi, sq ]
