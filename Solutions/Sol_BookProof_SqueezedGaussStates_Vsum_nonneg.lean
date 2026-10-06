-- Generated from ChapterSqueezedGaussStates.lean — solution of BookProof.SqueezedGaussStates.Vsum_nonneg
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Theorems.Thm_BookProof_SqueezedGaussStates_Acoef_nonneg
open BookProof.SqueezedGaussStates




open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ) (M : ℕ) : 0 ≤ Vsum v M := Finset.sum_nonneg fun m _ => Acoef_nonneg v m
