-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.LadderOrd.norm_sq_le
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_hn_zero_eq
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
    (hT : LadderOrd T n) :
    ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ p, ENNReal.ofReal (‖pgLp (T p)‖ ^ 2) ≤ C * hn n (pgLp p) := by

  obtain ⟨C, hC, h⟩ := hT 0
  refine ⟨C, hC, fun p => ?_⟩
  rw [← hn_zero_eq]
  simpa using h p
