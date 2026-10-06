-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.coordComboSum_sqCoef
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo
open BookProof.SqueezedGaussStates

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section


theorem BookProof.SqueezedGaussStates.coordComboSum_sqCoef (v : ℝ) (M : ℕ) : coordComboSum (sqCoef v M) 0 M = Vsum v M := by sorry
