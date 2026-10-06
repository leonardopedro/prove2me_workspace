-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.gaussInt_prod_coordFactor
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore

noncomputable section


theorem BookProof.GaussCoordCombo.gaussInt_prod_coordFactor {S : Finset (Fin d)} {W : Fin d → MvPolynomial (Fin d) ℂ}
    {s : Fin d → ℝ} (hW : ∀ j ∈ S, CoordFactor j (W j) (s j))
    {R : MvPolynomial (Fin d) ℂ} (hR : ∀ j ∈ S, pderiv j R = 0) :
    gaussInt ((∏ j ∈ S, W j) * ((∏ j ∈ S, W j) * R))
      = ((∏ j ∈ S, s j : ℝ) : ℂ) * gaussInt R := by sorry
