-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.hn_smul
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_coef_smul
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (m : ℕ) (c : ℂ) (v : L2d d) : hn m (c • v) = ‖c‖ₑ ^ 2 * hn m v := by

  unfold hn
  rw [← ENNReal.tsum_mul_left]
  refine tsum_congr fun a => ?_
  rw [coef_smul, enorm_mul, mul_pow]
  ring
