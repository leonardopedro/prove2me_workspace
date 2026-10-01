-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.exp_smul_I_unitary
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]


open scoped BigOperators Matrix TensorProduct



-/
theorem BookProof.ChapterContinuityUnitary.exp_smul_I_unitary {n : Type*} [Fintype n] [DecidableEq n]
    (A : Matrix n n ℂ) (hA : Aᴴ = A) (t : ℝ) :
    (NormedSpace.exp (((t : ℂ) * Complex.I) • A))ᴴ *
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 := by
  set B : Matrix n n ℂ := ((t : ℂ) * Complex.I) • := by sorry
