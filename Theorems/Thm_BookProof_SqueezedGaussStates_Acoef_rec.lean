-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.Acoef_rec
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}


theorem BookProof.SqueezedGaussStates.Acoef_rec (v : ℝ) (m : ℕ) :
    (2 * (m : ℝ) + 2) * Acoef v (m + 1) = 4 * v ^ 2 * (2 * (m : ℝ) + 1) * Acoef v m := by sorry
