-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.annPoly_eq_coreD
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_apply
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
    annPoly i p = coreD i p + C (1 / 2 : ℂ) * (X i * p) := by

  rw [annPoly_apply, coreD]
  ring
