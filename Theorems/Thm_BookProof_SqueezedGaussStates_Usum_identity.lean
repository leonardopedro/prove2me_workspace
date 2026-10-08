-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.Usum_identity
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}


theorem BookProof.SqueezedGaussStates.Usum_identity (v : ℝ) (M : ℕ) :
    (1 - 4 * v ^ 2) * Usum v M = Vsum v M - 4 * v ^ 2 * (2 * (M : ℝ) + 1) * Acoef v M := by sorry
