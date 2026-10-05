-- Generated from ChapterUnboundedSpectralModel.lean — solution of BookProof.UnboundedSpectralModel.op_resOp
import Mathlib
import Definitions.Def_ChapterUnboundedSpectralModel
import Theorems.Thm_BookProof_UnboundedSpectralModel_resOp_mem
import Theorems.Thm_BookProof_UnboundedSpectralModel_resOp_eq_res
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
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
theorem solution (T : UnboundedSelfAdjoint H) (y : H) :
    T.op ⟨resOp T y, resOp_mem T y⟩ = y + Complex.I • resOp T y := by

  rw [resOp_eq_res]
  have h := T.op_res (l := 1) one_ne_zero y
  simp at h
  exact h
