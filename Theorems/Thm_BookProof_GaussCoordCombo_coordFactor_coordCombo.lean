-- Generated from ChapterGaussCoordCombo.lean — theorem BookProof.GaussCoordCombo.coordFactor_coordCombo
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.GaussCoordCombo

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore

noncomputable section


theorem BookProof.GaussCoordCombo.coordFactor_coordCombo (i : Fin d) (c : ℕ → ℝ) (p K : ℕ) :
    CoordFactor i (coordCombo i c p K) (coordComboSum c p K) := by sorry
