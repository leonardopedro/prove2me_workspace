-- Generated from ChapterBrstReducedTransfer.lean — solution of BookProof.BrstReducedTransfer.transfer_zero
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
open BookProof.BrstReducedTransfer




open BookProof BookProof.ChapterStoneResolvent


variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]

variable (Om : H →L[ℂ] H)

variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]
variable (Om : H →L[ℂ] H)
variable {Om}
variable (Om)
variable (U : ℝ → (H →L[ℂ] H)) (hcomm : ∀ (t : ℝ) (y : H), U t (Om y) = Om (U t y))

set_option maxHeartbeats 1000000 in
theorem solution (hzero : ∀ x : H, U 0 x = x) :
    transfer Om U hcomm 0 = LinearMap.id := by

  refine LinearMap.ext fun c => ?_
  induction c using Submodule.Quotient.induction_on with
  | H x =>
    rw [transfer_mk, LinearMap.id_apply]
    congr 1
    exact Subtype.ext (hzero x)
