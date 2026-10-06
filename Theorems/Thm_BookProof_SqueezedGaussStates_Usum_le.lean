-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.Usum_le
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section


theorem BookProof.SqueezedGaussStates.Usum_le (v : ℝ) (M : ℕ) :
    (1 - 4 * v ^ 2) * Usum v M ≤ Vsum v M := by sorry
