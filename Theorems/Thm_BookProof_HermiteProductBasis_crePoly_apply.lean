-- Generated from ChapterHermiteProductBasis.lean — theorem BookProof.HermiteProductBasis.crePoly_apply
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteProductBasis

variable {d : ℕ}



open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section


theorem BookProof.HermiteProductBasis.crePoly_apply (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    crePoly i p = X i * p - pderiv i p := by sorry
