-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.LadderOrd.sub
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_add
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_neg
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {S T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {n : ℕ}
    (hS : LadderOrd S n) (hT : LadderOrd T n) : LadderOrd (S - T) n := by

  rw [sub_eq_add_neg]
  exact hS.add hT.neg
