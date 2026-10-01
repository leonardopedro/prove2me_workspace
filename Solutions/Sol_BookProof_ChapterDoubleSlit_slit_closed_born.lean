-- Generated from ChapterDoubleSlit.lean — solution of BookProof.ChapterDoubleSlit.slit_closed_born
import Mathlib
import Definitions.Def_ChapterDoubleSlit
import Theorems.Thm_BookProof_ChapterDoubleSlit_Hpsi0
open BookProof.ChapterDoubleSlit



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 2) : bornProb (H *ᵥ psi0) i = 1 / 2 := by

  rw [Hpsi0]
  simp only [bornProb]
  rw [show (1 / Real.sqrt 2 : ℂ) = ((Real.sqrt 2 : ℝ):ℂ)⁻¹ by rw [one_div]]
  rw [norm_inv, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Real.sqrt_nonneg 2), inv_pow,
    Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]
  norm_num
