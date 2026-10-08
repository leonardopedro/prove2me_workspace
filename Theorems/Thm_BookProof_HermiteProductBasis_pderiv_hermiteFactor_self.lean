-- Generated from ChapterHermiteProductBasis.lean — theorem BookProof.HermiteProductBasis.pderiv_hermiteFactor_self
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.HermiteProductBasis



open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteProductBasis.pderiv_hermiteFactor_self (i : Fin d) (n : ℕ) :
    pderiv i (hermiteFactor i n) = (n : ℂ) • hermiteFactor i (n - 1) := by sorry
