-- Generated from ChapterParityHiggs.lean — solution of BookProof.ChapterParityHiggs.pseudoreal_kron_pseudoreal_real
import Mathlib
import Definitions.Def_ChapterParityHiggs
import Theorems.Thm_BookProof_ChapterParityHiggs_kronecker_map_conj
open BookProof.ChapterParityHiggs



open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution
    {m n : Type*} [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n]
    (A : Matrix m m ℂ) (B : Matrix n n ℂ)
    (hA : A * A.map (starRingEnd ℂ) = -1) (hB : B * B.map (starRingEnd ℂ) = -1) :
    (A ⊗ₖ B) * ((A ⊗ₖ B).map (starRingEnd ℂ)) = 1 := by

  rw [kronecker_map_conj, ← Matrix.mul_kronecker_mul, hA, hB,
      show (-1 : Matrix m m ℂ) = (-1 : ℂ) • 1 from by simp,
      show (-1 : Matrix n n ℂ) = (-1 : ℂ) • 1 from by simp,
      Matrix.smul_kronecker, Matrix.kronecker_smul, Matrix.one_kronecker_one, smul_smul]
  norm_num
