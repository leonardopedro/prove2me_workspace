-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.Acoef_nonneg
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ) (m : ℕ) : 0 ≤ Acoef v m := by

  unfold Acoef
  positivity
