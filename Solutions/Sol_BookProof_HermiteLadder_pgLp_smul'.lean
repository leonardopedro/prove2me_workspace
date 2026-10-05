-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.pgLp_smul'
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
theorem solution (c : ℂ) (p : MvPolynomial (Fin d) ℂ) : pgLp (c • p) = c • pgLp p := by

  rw [← HermiteProductCore.pgMap_apply, map_smul]
  rfl
