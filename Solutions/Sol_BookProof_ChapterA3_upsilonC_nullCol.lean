-- Generated from ChapterA4d.lean — solution of BookProof.ChapterA3.upsilonC_nullCol
import Mathlib
import Definitions.Def_ChapterA4d
import Theorems.Thm_BookProof_ChapterA3_pauliCoeff_add
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    UpsilonC T μ 0 + UpsilonC T μ 3 = pauliCoeff (Tᴴ * (pauliσ 0 + pauliσ 3) * T) μ := by

  unfold UpsilonC
  simp only [Matrix.of_apply]
  rw [← pauliCoeff_add]
  congr 1
  simp [Matrix.mul_add, Matrix.add_mul]
