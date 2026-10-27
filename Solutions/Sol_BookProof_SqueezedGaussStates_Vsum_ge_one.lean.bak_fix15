-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.Vsum_ge_one
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_zero
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_nonneg
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ) (M : ℕ) : 1 ≤ Vsum v M := by

  have h0 : Acoef v 0 ≤ Vsum v M := by
    refine Finset.single_le_sum (f := fun m => Acoef v m) (fun m _ => Acoef_nonneg v m) ?_
    simp
  rw [Acoef_zero] at h0
  exact h0
