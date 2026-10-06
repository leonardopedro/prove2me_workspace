-- Generated from ChapterA3i.lean — solution of BookProof.ChapterA3.Treal_mul
import Mathlib
import Definitions.Def_ChapterA3i
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    Treal (A * B) = Treal A * Treal B := by

  unfold Treal;
  ext i j;    fin_cases i <;> fin_cases j <;> simp [ Matrix.mul_apply, Fin.sum_univ_succ ] <;> ring;
