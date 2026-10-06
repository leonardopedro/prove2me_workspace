-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.pderiv_prod_eq_zero
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore

noncomputable section


theorem BookProof.GaussCoordCombo.pderiv_prod_eq_zero {S : Finset (Fin d)} {W : Fin d → MvPolynomial (Fin d) ℂ}
    {i : Fin d} (h : ∀ j ∈ S, pderiv i (W j) = 0) : pderiv i (∏ j ∈ S, W j) = 0 := by sorry
