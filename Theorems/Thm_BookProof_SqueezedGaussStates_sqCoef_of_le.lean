-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.sqCoef_of_le
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section


theorem BookProof.SqueezedGaussStates.sqCoef_of_le {v : ℝ} {M m : ℕ} (h : m ≤ M) :
    sqCoef v M m = v ^ m / (m.factorial : ℝ) := by sorry
