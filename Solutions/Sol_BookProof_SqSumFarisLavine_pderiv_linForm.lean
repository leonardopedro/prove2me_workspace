-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.pderiv_linForm
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin D → ℝ) (j : Fin D) :
    pderiv j (linForm v) = C ((v j : ℝ) : ℂ) := by

  rw [linForm, map_sum, Finset.sum_eq_single j]
  · rw [MvPolynomial.smul_eq_C_mul, pderiv_C_mul, pderiv_X_self, mul_one]
  · intro i _ hi
    simp [MvPolynomial.smul_eq_C_mul, pderiv_X, Ne.symm hi]
  · intro h
    exact absurd (Finset.mem_univ j) h
