-- Generated from ChapterYangMillsAbelianNoGap.lean — theorem BookProof.YangMillsAbelianNoGap.le_of_sq_le
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
open BookProof.YangMillsAbelianNoGap

variable {d : ℕ}
variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)



open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section


theorem BookProof.YangMillsAbelianNoGap.le_of_sq_le {a t b : ℝ} (ht : 0 ≤ t) (hb : 0 ≤ b)
    (h : a ^ 2 ≤ t ^ 2 * b ^ 2) : a ≤ t * b := by sorry
