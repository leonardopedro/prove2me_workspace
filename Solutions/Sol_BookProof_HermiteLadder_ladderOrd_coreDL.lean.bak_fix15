-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.ladderOrd_coreDL
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_smul
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_sub
import Theorems.Thm_BookProof_HermiteLadder_ladderOrd_annPoly
import Theorems.Thm_BookProof_HermiteLadder_ladderOrd_crePoly
import Theorems.Thm_BookProof_HermiteLadder_coreDL_eq
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin d) : LadderOrd (coreDL j) 1 := by

  rw [coreDL_eq]
  exact ((ladderOrd_annPoly j).smul _).sub ((ladderOrd_crePoly j).smul _)
