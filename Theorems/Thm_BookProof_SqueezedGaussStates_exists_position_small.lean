-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.exists_position_small
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo
open BookProof.SqueezedGaussStates



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}


theorem BookProof.SqueezedGaussStates.exists_position_small {ε : ℝ} (hε : 0 < ε) :
    ∃ (v : ℝ) (M : ℕ), 4 * v ^ 2 < 1 ∧
      coordComboSum (opCoef 1 0 v M) 1 M ≤ ε * coordComboSum (sqCoef v M) 0 M := by sorry
