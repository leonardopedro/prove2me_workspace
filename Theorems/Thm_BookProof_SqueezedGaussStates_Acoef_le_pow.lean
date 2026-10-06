-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.Acoef_le_pow
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section


theorem BookProof.SqueezedGaussStates.Acoef_le_pow (v : ℝ) (M : ℕ) : Acoef v M ≤ (4 * v ^ 2) ^ M := by sorry
