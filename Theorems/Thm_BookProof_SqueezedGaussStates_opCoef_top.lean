-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.opCoef_top
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section


theorem BookProof.SqueezedGaussStates.opCoef_top (α γ v : ℝ) (M : ℕ) : opCoef α γ v M M = α * sqCoef v M M := by sorry
