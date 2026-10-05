-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.enorm_add_sq_le
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x y : ℂ) : ‖x + y‖ₑ ^ 2 ≤ 2 * ‖x‖ₑ ^ 2 + 2 * ‖y‖ₑ ^ 2 := by

  have h1 : ‖x + y‖ₑ ≤ ‖x‖ₑ + ‖y‖ₑ := enorm_add_le _ _
  have h2 : (‖x‖ₑ + ‖y‖ₑ) ^ 2 ≤ 2 * ‖x‖ₑ ^ 2 + 2 * ‖y‖ₑ ^ 2 := by
    rw [enorm_eq_nnnorm, enorm_eq_nnnorm]
    have h3 : ((‖x‖₊ + ‖y‖₊) ^ 2 : NNReal) ≤ 2 * ‖x‖₊ ^ 2 + 2 * ‖y‖₊ ^ 2 := by
      rw [← NNReal.coe_le_coe]
      push_cast
      nlinarith [sq_nonneg (‖x‖ - ‖y‖)]
    exact_mod_cast h3
  exact (pow_le_pow_left₀ (M₀ := ℝ≥0∞) (by simp) h1 2).trans h2
