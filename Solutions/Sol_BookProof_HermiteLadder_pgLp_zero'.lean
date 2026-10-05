-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.pgLp_zero'
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteProductCore_pgMap_apply
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : pgLp (0 : MvPolynomial (Fin d) ℂ) = 0 := by

  rw [← HermiteProductCore.pgMap_apply, map_zero]
