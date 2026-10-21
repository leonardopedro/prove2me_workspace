-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.exists_resOp_eq
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_res_shift
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
theorem solution (T : UnboundedSelfAdjoint H) {x : H} (hx : x ∈ T.domain) :
    ∃ y : H, resOp T y = x := by

  refine ⟨T.shift 1 ⟨x, hx⟩, ?_⟩
  have h := T.res_shift (l := 1) one_ne_zero ⟨x, hx⟩
  have := congrArg (fun w : T.domain => (w : H)) h
  simpa [resOp, UnboundedSelfAdjoint.resCLM_apply] using this
