-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.qgOneParticleHermite_friedrichs_unique
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsCanonical_friedrichs_unique_selfAdjoint
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
theorem solution (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    {Dom' : Submodule ℂ (L2d 1)} (A' : Dom' →ₗ[ℂ] L2d 1)
    (hA' : IsPositiveSelfAdjointExtension
      (hamCore (scalaronW M alpha) (continuous_scalaronW M alpha) (expBounded_scalaronW M alpha hM))
      A')
    (hform : Dom' ≤ formDomain (qgScalaronPosSymOp M alpha hM halpha)) :
    Dom' = friedrichsDomain (qgScalaronPosSymOp M alpha hM halpha) ∧
      ∀ (x : L2d 1) (hx : x ∈ Dom')
        (hx' : x ∈ friedrichsDomain (qgScalaronPosSymOp M alpha hM halpha)),
        A' ⟨x, hx⟩ = friedrichsOp (qgScalaronPosSymOp M alpha hM halpha)
          (qgScalaronPosSymOp_dense M alpha hM halpha) ⟨x, hx'⟩ :=
  friedrichs_unique_selfAdjoint (qgScalaronPosSymOp M alpha hM halpha)
      (qgScalaronPosSymOp_dense M alpha hM halpha) A' hA' hform
