-- Generated from ChapterYangMillsAbelianNoGap.lean — theorem BookProof.YangMillsAbelianNoGap.norm_pgLp_sq
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.YangMillsAbelianNoGap

variable {d : ℕ}



open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section


theorem BookProof.YangMillsAbelianNoGap.norm_pgLp_sq {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q) {r : ℝ}
    (h : gaussInt (q * q) = ((r : ℝ) : ℂ)) : ‖pgLp q‖ ^ 2 = r := by sorry
