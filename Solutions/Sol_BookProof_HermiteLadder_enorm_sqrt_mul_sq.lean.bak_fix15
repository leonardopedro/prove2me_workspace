-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.enorm_sqrt_mul_sq
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
theorem solution {x : ℝ} (hx : 0 ≤ x) (c : ℂ) :
    ‖((Real.sqrt x : ℝ) : ℂ) * c‖ₑ ^ 2 = ENNReal.ofReal x * ‖c‖ₑ ^ 2 := by

  rw [enorm_mul, mul_pow]
  congr 1
  rw [show ‖((Real.sqrt x : ℝ) : ℂ)‖ₑ = ENNReal.ofReal (Real.sqrt x) by
    rw [← ofReal_norm_eq_enorm, Complex.norm_real, Real.norm_of_nonneg (Real.sqrt_nonneg _)]]
  rw [← ENNReal.ofReal_pow (Real.sqrt_nonneg _), Real.sq_sqrt hx]
