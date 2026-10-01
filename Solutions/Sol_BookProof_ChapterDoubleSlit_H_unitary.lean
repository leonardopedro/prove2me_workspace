-- Generated from ChapterDoubleSlit.lean — solution of BookProof.ChapterDoubleSlit.H_unitary
import Mathlib
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : Hᴴ * H = 1 := by

  have h2 : (Real.sqrt 2 : ℂ) * (Real.sqrt 2 : ℂ) = 2 := by
    exact_mod_cast Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 2)
  have hpos : (0:ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  have hne : (Real.sqrt 2 : ℂ) ≠ 0 := by exact_mod_cast hpos.ne'
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [H, Matrix.mul_apply, Matrix.conjTranspose_apply, Fin.sum_univ_two] <;>
    field_simp <;> (try linear_combination -h2)
