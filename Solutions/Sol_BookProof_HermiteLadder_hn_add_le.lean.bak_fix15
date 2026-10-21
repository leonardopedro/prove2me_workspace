-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.hn_add_le
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_coef_add
import Theorems.Thm_BookProof_HermiteLadder_enorm_add_sq_le
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (v w : L2d d) : hn m (v + w) ≤ 2 * hn m v + 2 * hn m w := by

  unfold hn
  rw [← ENNReal.tsum_mul_left, ← ENNReal.tsum_mul_left, ← ENNReal.tsum_add]
  refine ENNReal.tsum_le_tsum fun a => ?_
  rw [coef_add]
  calc wt m a * ‖coef a v + coef a w‖ₑ ^ 2
      ≤ wt m a * (2 * ‖coef a v‖ₑ ^ 2 + 2 * ‖coef a w‖ₑ ^ 2) :=
        by gcongr; exact enorm_add_sq_le _ _
    _ = 2 * (wt m a * ‖coef a v‖ₑ ^ 2) + 2 * (wt m a * ‖coef a w‖ₑ ^ 2) := by ring
