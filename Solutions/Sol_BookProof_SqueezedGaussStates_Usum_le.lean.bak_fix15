-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.Usum_le
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_nonneg
import Theorems.Thm_BookProof_SqueezedGaussStates_Usum_identity
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ) (M : ℕ) :
    (1 - 4 * v ^ 2) * Usum v M ≤ Vsum v M := by

  have h := Usum_identity v M
  have hA : 0 ≤ 4 * v ^ 2 * (2 * (M : ℝ) + 1) * Acoef v M := by
    have := Acoef_nonneg v M
    positivity
  linarith
