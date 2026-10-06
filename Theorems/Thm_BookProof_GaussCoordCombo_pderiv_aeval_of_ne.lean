-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.pderiv_aeval_of_ne
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore

noncomputable section


theorem BookProof.GaussCoordCombo.pderiv_aeval_of_ne {i j : Fin d} (h : j ≠ i) (f : Polynomial ℂ) :
    pderiv j (Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) f) = 0 := by sorry
