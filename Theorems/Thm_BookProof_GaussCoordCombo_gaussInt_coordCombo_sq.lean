-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.gaussInt_coordCombo_sq
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo



open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}


theorem BookProof.GaussCoordCombo.gaussInt_coordCombo_sq (i : Fin d) (c : ℕ → ℝ) (p K : ℕ)
    {R : MvPolynomial (Fin d) ℂ} (hR : pderiv i R = 0) :
    gaussInt (coordCombo i c p K * (coordCombo i c p K * R))
      = ((coordComboSum c p K : ℝ) : ℂ) * gaussInt R := by sorry
