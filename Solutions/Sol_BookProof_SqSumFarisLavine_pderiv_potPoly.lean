-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.pderiv_potPoly
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Theorems.Thm_BookProof_SqSumFarisLavine_pderiv_linForm
import Theorems.Thm_BookProof_SqSumFarisLavine_C_two_eq
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterFarisLavine
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution (v : R → Fin D → ℝ) (k : Fin D) :
    pderiv k (potPoly v) = gradPoly v k := by

  rw [potPoly, MvPolynomial.smul_eq_C_mul, pderiv_C_mul, map_sum, gradPoly, Finset.mul_sum]
  refine Finset.sum_congr rfl fun r _ => ?_
  rw [pderiv_mul, pderiv_linForm, MvPolynomial.smul_eq_C_mul,
    show (C (((1 : ℝ) / 2 : ℝ) : ℂ) : MvPolynomial (Fin D) ℂ)
        * (C ((v r k : ℝ) : ℂ) * linForm (v r) + linForm (v r) * C ((v r k : ℝ) : ℂ))
      = (C (((1 : ℝ) / 2 : ℝ) : ℂ) * C ((v r k : ℝ) : ℂ) * C (2 : ℂ)) * linForm (v r) by
      rw [C_two_eq]; ring]
  congr 1
  rw [← map_mul, ← map_mul]
  congr 1
  push_cast
  ring
