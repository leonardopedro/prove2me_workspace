-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.coordComboSum_sqCoef
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Theorems.Thm_BookProof_SqueezedGaussStates_sqCoef_of_le
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ) (M : ℕ) : coordComboSum (sqCoef v M) 0 M = Vsum v M := by

  rw [coordComboSum, Vsum]
  refine Finset.sum_congr rfl fun m hm => ?_
  rw [sqCoef_of_le (Nat.lt_succ_iff.mp (Finset.mem_range.mp hm)), Acoef]
  simp
