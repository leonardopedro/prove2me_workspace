-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.coordComboSum_opCoef_le
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo
open BookProof.SqueezedGaussStates

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section


theorem BookProof.SqueezedGaussStates.coordComboSum_opCoef_le (α γ v : ℝ) (M : ℕ) (hv : 4 * v ^ 2 < 1) :
    coordComboSum (opCoef α γ v M) 1 M
      ≤ ((kappa α γ v) ^ 2 / (1 - 4 * v ^ 2) + α ^ 2 * (2 * (M : ℝ) + 1) * (4 * v ^ 2) ^ M)
        * coordComboSum (sqCoef v M) 0 M := by sorry
