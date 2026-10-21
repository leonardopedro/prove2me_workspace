-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.facS_pos
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Theorems.Thm_BookProof_SqueezedGaussStates_Vsum_ge_one
import Theorems.Thm_BookProof_SqueezedGaussStates_coordComboSum_sqCoef
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin d) : 0 < facS vf Mf j := by

  have h : coordComboSum (sqCoef (vf j) (Mf j)) 0 (Mf j) = Vsum (vf j) (Mf j) :=
    coordComboSum_sqCoef _ _
  rw [facS, h]
  linarith [Vsum_ge_one (vf j) (Mf j)]
