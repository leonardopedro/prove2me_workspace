-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.LadderOrd.neg
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_LadderOrd_smul
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {n : ℕ}
    (hT : LadderOrd T n) : LadderOrd (-T) n := by

  have heq : -T = (-1 : ℂ) • T := by
    refine LinearMap.ext fun p => ?_
    simp
  rw [heq]
  exact hT.smul (-1)
