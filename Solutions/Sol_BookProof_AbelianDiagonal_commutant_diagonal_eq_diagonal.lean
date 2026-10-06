-- Generated from ChapterAbelianDiagonal.lean — solution of BookProof.AbelianDiagonal.commutant_diagonal_eq_diagonal
import Mathlib
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal




open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix n n ℂ)
    (h : ∀ d : n → ℂ, M * Matrix.diagonal d = Matrix.diagonal d * M) :
    M = Matrix.diagonal (fun i => M i i) := by

  ext i j
  rcases eq_or_ne i j with rfl | hij
  · simp
  · have hd := congrFun (congrFun (h (Pi.single i 1)) i) j
    rw [Matrix.mul_diagonal, Matrix.diagonal_mul] at hd
    rw [Matrix.diagonal_apply_ne _ hij]
    simpa [Pi.single_apply, hij, Ne.symm hij] using hd.symm
