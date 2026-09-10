-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.norm_potPoly_mul_le
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Theorems.Thm_BookProof_SqSumFarisLavine_eval_potPoly
import Theorems.Thm_BookProof_SqSumFarisLavine_potFun_nonneg
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution {v : R → Fin D → ℝ} {B : ℝ} (hB0 : 0 ≤ B)
    (hB : ∀ x : Vd D, potFun v x ≤ B * ‖x‖ ^ 2) (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (potPoly v * p)‖ ≤ 4 * B * ‖pgLp (harmPoly * p)‖ := by

  refine norm_mul_le_of_pointwise (by positivity) (fun x => ?_) p
  rw [eval_potPoly, eval_harmPoly, Complex.norm_real, Complex.norm_real,
    Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg (potFun_nonneg v x),
    abs_of_nonneg (show (0 : ℝ) ≤ harmW x by rw [harmW]; positivity), harmW]
  have := hB x
  linarith
