-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.isStarNormal_resOp
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_adjoint_resCLM
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_comm
open BookProof.UnboundedSpectralModel



noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) : IsStarNormal (resOp T) := by

  constructor
  have hstar : star (resOp T) = T.resCLM (-1) := by
    rw [ContinuousLinearMap.star_eq_adjoint]
    exact adjoint_resCLM T one_ne_zero
  refine ContinuousLinearMap.ext fun y => ?_
  rw [hstar]
  simp only [ContinuousLinearMap.mul_apply]
  exact T.res_comm (l := -1) (m := 1) (by norm_num) one_ne_zero y
