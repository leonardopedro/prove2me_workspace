-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.norm_bigP_pos
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_gaussConst_pos
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_facS_pos
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_norm_bigP_sq
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution : 0 < ‖pgLp (bigP vf Mf)‖ ^ 2 := by

  rw [norm_bigP_sq]
  have hprod : 0 < ∏ j, facS vf Mf j :=
    Finset.prod_pos fun j _ => facS_pos vf Mf j
  have := gaussConst_pos (d := d)
  positivity
