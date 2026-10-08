-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.pderiv_hermiteFactor_of_ne
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo



open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}


theorem BookProof.GaussCoordCombo.pderiv_hermiteFactor_of_ne {i j : Fin d} (h : j ≠ i) (n : ℕ) :
    pderiv j (hermiteFactor i n) = 0 := by sorry
