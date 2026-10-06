-- Generated from ChapterYangMillsAbelianNoGap.lean — theorem BookProof.YangMillsAbelianNoGap.op_bigP
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSqueezedGaussStates
open BookProof.GaussCoordCombo
open BookProof.HermiteProductCore
open BookProof.SqueezedGaussStates
open BookProof.YangMillsAbelianNoGap

variable {d : ℕ}
variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)



open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section


theorem BookProof.YangMillsAbelianNoGap.op_bigP (c : Fin d) (α γ : ℝ) :
    ((α : ℝ) : ℂ) • (X c * bigP vf Mf) + ((γ : ℝ) : ℂ) • pderiv c (bigP vf Mf)
      = coordCombo c (opCoef α γ (vf c) (Mf c)) 1 (Mf c)
        * ∏ j ∈ Finset.univ.erase c, facW vf Mf j := by sorry
