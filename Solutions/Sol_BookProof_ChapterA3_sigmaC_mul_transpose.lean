-- Generated from ChapterA3i.lean — solution of BookProof.ChapterA3.sigmaC_mul_transpose
import Mathlib
import Definitions.Def_ChapterA3i
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution :
    SigmaC * SigmaCᵀ = (2 : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [SigmaC, SigmaZ, Matrix.mul_apply, Fin.sum_univ_four, Matrix.transpose_apply,
      RingHom.mapMatrix_apply, Matrix.smul_apply] <;> norm_num
