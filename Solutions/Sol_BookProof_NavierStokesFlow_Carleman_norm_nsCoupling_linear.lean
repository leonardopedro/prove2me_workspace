-- Generated from ChapterNavierStokesCarleman.lean — solution of BookProof.NavierStokesFlow.Carleman.norm_nsCoupling_linear
import Mathlib
import Definitions.Def_ChapterNavierStokesCarleman
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.Carleman



open scoped ENNReal



open LpNat DiagonalEsa FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    ‖nsCoupling (fun m : ℕ => (m : ℝ) + 1) n‖ = ((n : ℝ) + 3 / 2) := by

  have h : ((((n : ℝ) + 1 : ℝ)) : ℂ) + (((((n + 1 : ℕ) : ℝ) + 1 : ℝ)) : ℂ)
      = (((2 * (n : ℝ) + 3 : ℝ)) : ℂ) := by
    push_cast
    ring
  simp only [nsCoupling, h, norm_mul, norm_neg, norm_div, Complex.norm_I,
    Complex.norm_real, Real.norm_eq_abs]
  rw [abs_of_nonneg (by positivity : (0 : ℝ) ≤ 2 * (n : ℝ) + 3)]
  norm_num
  ring
