-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.ladderOrd_mulL_X
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_add
import Theorems.Thm_BookProof_HermiteLadder_ladderOrd_annPoly
import Theorems.Thm_BookProof_HermiteLadder_ladderOrd_crePoly
import Theorems.Thm_BookProof_HermiteLadder_mulL_X_eq
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : LadderOrd (mulL (X i : MvPolynomial (Fin d) ℂ)) 1 := by

  rw [mulL_X_eq]
  exact (ladderOrd_annPoly i).add (ladderOrd_crePoly i)
