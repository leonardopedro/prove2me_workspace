-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.isStarNormal_resOp_inc
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterSpectralDirectSum
import Definitions.Def_ChapterStoneResolvent
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
