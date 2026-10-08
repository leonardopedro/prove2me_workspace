-- Generated from ChapterSqueezedGaussStates.lean — theorem BookProof.SqueezedGaussStates.pderiv_coordCombo_even
import Mathlib
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.GaussCoordCombo
open BookProof.HermiteProductCore
open BookProof.SqueezedGaussStates



open MvPolynomial BookProof.HermiteProductCore BookProof.GaussCoordCombo

noncomputable section

variable {d : ℕ}


theorem BookProof.SqueezedGaussStates.pderiv_coordCombo_even (i : Fin d) (a : ℕ → ℝ) (M : ℕ) (ha : a (M + 1) = 0) :
    pderiv i (coordCombo i a 0 M) = coordCombo i (fun k => 2 * (k + 1) * a (k + 1)) 1 M := by sorry
