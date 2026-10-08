-- Generated from ChapterHermiteProductBasis.lean — theorem BookProof.HermiteProductBasis.pderiv_hermiteFactor_other
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.HermiteProductBasis



open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteProductBasis.pderiv_hermiteFactor_other {i j : Fin d} (h : j ≠ i) (n : ℕ) :
    pderiv j (hermiteFactor i n) = 0 := by sorry
