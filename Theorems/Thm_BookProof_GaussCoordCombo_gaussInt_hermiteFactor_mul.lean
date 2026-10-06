-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.gaussInt_hermiteFactor_mul
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore

noncomputable section


theorem BookProof.GaussCoordCombo.gaussInt_hermiteFactor_mul (i : Fin d) (m n : ℕ) {R : MvPolynomial (Fin d) ℂ}
    (hR : pderiv i R = 0) :
    gaussInt (hermiteFactor i m * (hermiteFactor i n * R))
      = (if m = n then (n.factorial : ℂ) else 0) * gaussInt R := by sorry
