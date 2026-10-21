-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.norm_bigP_sq
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_norm_pgLp_sq
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_realCoeff_bigP
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_gaussInt_bigP
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution :
    ‖pgLp (bigP vf Mf)‖ ^ 2 = (∏ j, facS vf Mf j) * (Real.sqrt (2 * Real.pi)) ^ d := norm_pgLp_sq (realCoeff_bigP vf Mf) (gaussInt_bigP vf Mf)
