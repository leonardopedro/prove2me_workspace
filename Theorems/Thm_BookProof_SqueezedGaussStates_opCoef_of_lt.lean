-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.opCoef_of_lt
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.SqueezedGaussStates

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section


theorem BookProof.SqueezedGaussStates.opCoef_of_lt (α γ v : ℝ) {M k : ℕ} (hk : k < M) :
    opCoef α γ v M k = kappa α γ v * sqCoef v M k := by sorry
