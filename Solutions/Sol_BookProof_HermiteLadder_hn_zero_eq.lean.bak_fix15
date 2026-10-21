-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.hn_zero_eq
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_wt_zero
import Theorems.Thm_BookProof_HermiteLadder_coef_eq_repr
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : L2d d) : hn 0 v = ENNReal.ofReal (‖v‖ ^ 2) := by

  have hsum := lp.hasSum_norm (p := 2) (by norm_num) (hermiteMvBasis.repr v)
  simp only [LinearIsometryEquiv.norm_map] at hsum
  have h2 : ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) := by norm_num
  simp only [h2, Real.rpow_natCast] at hsum
  unfold hn
  simp only [wt_zero, one_mul]
  have hpt : ∀ a, ‖coef a v‖ₑ ^ 2 = ENNReal.ofReal (‖(hermiteMvBasis.repr v : _) a‖ ^ 2) := by
    intro a
    rw [coef_eq_repr, ← ofReal_norm_eq_enorm, ENNReal.ofReal_pow (norm_nonneg _)]
  simp only [hpt]
  rw [← ENNReal.ofReal_tsum_of_nonneg (fun a => by positivity) hsum.summable, hsum.tsum_eq]
