-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.coreDL_eq
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_C_half_add_C_half
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin d) :
    coreDL j = (1 / 2 : ℂ) • annPoly j - (1 / 2 : ℂ) • crePoly j := by

  refine LinearMap.ext fun p => ?_
  simp only [coreDL_apply, LinearMap.sub_apply, LinearMap.smul_apply, annPoly_apply,
    crePoly_apply, coreD, smul_eq_C_mul]
  linear_combination (-(pderiv j p)) * (C_half_add_C_half (d := d))
