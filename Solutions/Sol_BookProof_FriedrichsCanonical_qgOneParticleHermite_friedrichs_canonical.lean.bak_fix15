-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.qgOneParticleHermite_friedrichs_canonical
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsCanonical_friedrichsOp_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_FriedrichsCanonical_qgScalaronPosSymOp_dense
import Theorems.Thm_BookProof_QgHermiteFriedrichs_continuous_scalaronW
import Theorems.Thm_BookProof_QgHermiteFriedrichs_expBounded_scalaronW
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) :
    IsPositiveSelfAdjointExtension
      (hamCore (scalaronW M alpha) (continuous_scalaronW M alpha) (expBounded_scalaronW M alpha hM))
      (friedrichsOp (qgScalaronPosSymOp M alpha hM halpha)
        (qgScalaronPosSymOp_dense M alpha hM halpha)) :=
  friedrichsOp_isPositiveSelfAdjointExtension (qgScalaronPosSymOp M alpha hM halpha)
      (qgScalaronPosSymOp_dense M alpha hM halpha)
