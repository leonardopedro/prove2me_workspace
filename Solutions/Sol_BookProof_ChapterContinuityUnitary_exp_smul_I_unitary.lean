-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.exp_smul_I_unitary
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
-/
theorem solution {n : Type*} [Fintype n] [DecidableEq n]
    (A : Matrix n n ℂ) (hA : Aᴴ = A) (t : ℝ) :
    (NormedSpace.exp (((t : ℂ) * Complex.I) • A))ᴴ *
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 := by
  set B : Matrix n n ℂ := ((t : ℂ) * Complex.I) • :=
  A with hB
    have hBstar : Bᴴ = -B := by
      simp only [hB, Matrix.conjTr
