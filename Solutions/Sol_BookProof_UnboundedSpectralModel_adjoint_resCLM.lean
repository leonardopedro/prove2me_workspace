-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.adjoint_resCLM
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_inner_res
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
theorem solution (T : UnboundedSelfAdjoint H) {l : ℝ} (hl : l ≠ 0) :
    ContinuousLinearMap.adjoint (T.resCLM l) = T.resCLM (-l) := by

  refine ((ContinuousLinearMap.eq_adjoint_iff (T.resCLM (-l)) (T.resCLM l)).mpr ?_).symm
  intro y z
  simpa using T.inner_res (l := -l) (neg_ne_zero.mpr hl) y z
