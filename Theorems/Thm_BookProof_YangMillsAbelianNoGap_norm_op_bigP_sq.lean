-- Generated from ChapterYangMillsAbelianNoGap.lean — theorem BookProof.YangMillsAbelianNoGap.norm_op_bigP_sq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterYangMillsHermite
open BookProof.GaussCoordCombo
open BookProof.HermiteProductCore
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite
open BookProof.YangMillsAbelianNoGap



open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

theorem BookProof.YangMillsAbelianNoGap.norm_op_bigP_sq (c : Fin d) (α γ : ℝ) :
    ‖pgLp (((α : ℝ) : ℂ) • (X c * bigP vf Mf) + ((γ : ℝ) : ℂ) • pderiv c (bigP vf Mf))‖ ^ 2
      = (coordComboSum (opCoef α γ (vf c) (Mf c)) 1 (Mf c))
        * (∏ j ∈ Finset.univ.erase c, facS vf Mf j) * (Real.sqrt (2 * Real.pi)) ^ d := by sorry
