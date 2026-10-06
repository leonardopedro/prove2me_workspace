-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.hermiteFactor_succ_eq
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore

noncomputable section


theorem BookProof.GaussCoordCombo.hermiteFactor_succ_eq (i : Fin d) (n : ℕ) :
    hermiteFactor i (n + 1) = X i * hermiteFactor i n - pderiv i (hermiteFactor i n) := by sorry
