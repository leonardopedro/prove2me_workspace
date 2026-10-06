-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.opCoef_top
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Theorems.Thm_BookProof_SqueezedGaussStates_sqCoef_top_succ
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (α γ v : ℝ) (M : ℕ) : opCoef α γ v M M = α * sqCoef v M M := by

  rw [opCoef, sqCoef_top_succ]
  ring
