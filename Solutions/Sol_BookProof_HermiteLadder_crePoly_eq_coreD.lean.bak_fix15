-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.crePoly_eq_coreD
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_C_half_add_C_half
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_apply
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    crePoly i p = C (1 / 2 : ℂ) * (X i * p) - coreD i p := by

  rw [crePoly_apply, coreD]
  linear_combination (-(X i * p)) * (C_half_add_C_half (d := d))
