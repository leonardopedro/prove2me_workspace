-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.generationOperator_conjTranspose_mul
import Mathlib
import Definitions.Def_ChapterH7
import Theorems.Thm_BookProof_ChapterH7_generationOperator_conjTranspose
open BookProof.ChapterH7



noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) :
    (generationOperator A t)ᴴ * generationOperator A t = 1 := by

  have hcomm : Commute ((Complex.I * (t : ℂ)) • A) ((-Complex.I * (t : ℂ)) • A) := by
    unfold Commute SemiconjBy
    rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_smul, smul_smul, smul_smul,
      mul_comm (Complex.I * (t : ℂ)) (-Complex.I * (t : ℂ))]
  rw [generationOperator_conjTranspose A t hA, generationOperator,
    ← Matrix.exp_add_of_commute _ _ hcomm]
  rw [← add_smul]
  rw [show (Complex.I * (t : ℂ)) + (-Complex.I * (t : ℂ)) = 0 by ring]
  simp
