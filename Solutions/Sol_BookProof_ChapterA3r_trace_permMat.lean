-- Generated from ChapterA3r.lean — solution of BookProof.ChapterA3r.trace_permMat
import Mathlib
import Definitions.Def_ChapterA3r
open BookProof.ChapterA3r



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (σ : Equiv.Perm (Fin N)) :
    Matrix.trace (permMat σ) =
      ((Finset.univ.filter (fun a : Idx N => a ∘ σ = a)).card : ℂ) := by

  simp only [Matrix.trace, Matrix.diag, permMat, Matrix.of_apply]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const_zero, add_zero,
    nsmul_eq_mul, mul_one]
  congr 2
  ext a
  simp [eq_comm]
