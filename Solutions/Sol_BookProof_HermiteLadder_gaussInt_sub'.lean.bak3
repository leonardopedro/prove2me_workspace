-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.gaussInt_sub'
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_add
import Theorems.Thm_BookProof_QgHermiteFriedrichs_gaussInt_neg
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (r s : MvPolynomial (Fin d) ℂ) :
    gaussInt (r - s) = gaussInt r - gaussInt s := by

  rw [sub_eq_add_neg, gaussInt_add, gaussInt_neg, ← sub_eq_add_neg]
