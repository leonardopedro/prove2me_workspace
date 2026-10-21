-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.LadderOrd.smul
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_hn_smul
import Theorems.Thm_BookProof_HermiteLadder_pgLp_smul_prime
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
    (hT : LadderOrd T n) (c : ℂ) : LadderOrd (c • T) n := by

  intro m
  obtain ⟨C, hC, h⟩ := hT m
  refine ⟨‖c‖ₑ ^ 2 * C, by finiteness, fun p => ?_⟩
  rw [LinearMap.smul_apply, pgLp_smul_prime, hn_smul, mul_assoc]
  gcongr
  exact h p
