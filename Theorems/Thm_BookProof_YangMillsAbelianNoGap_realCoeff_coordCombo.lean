-- Generated from ChapterYangMillsAbelianNoGap.lean — theorem BookProof.YangMillsAbelianNoGap.realCoeff_coordCombo
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.GaussCoordCombo
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.YangMillsAbelianNoGap

variable {d : ℕ}



open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section


theorem BookProof.YangMillsAbelianNoGap.realCoeff_coordCombo (i : Fin d) (c : ℕ → ℝ) (p K : ℕ) :
    RealCoeff (coordCombo i c p K) := by sorry
