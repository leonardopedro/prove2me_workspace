-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.pderiv_aeval_self
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore

noncomputable section


theorem BookProof.GaussCoordCombo.pderiv_aeval_self (i : Fin d) (f : Polynomial ℂ) :
    pderiv i (Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) f)
      = Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) (Polynomial.derivative f) := by sorry
