-- Generated from ChapterBrstReducedTransfer.lean — solution of BookProof.BrstReducedTransfer.transfer_apply_transfer
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
import Theorems.Thm_BookProof_BrstReducedTransfer_transfer_comp
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
theorem solution (hgroup : ∀ (s t : ℝ) (x : H), U s (U t x) = U (s + t) x)
    (s t : ℝ) (c : Cohomology Om) :
    transfer Om U hcomm s (transfer Om U hcomm t c) = transfer Om U hcomm (s + t) c := by

  have := congrArg (fun L : Cohomology Om →ₗ[ℂ] Cohomology Om => L c)
    (transfer_comp Om U hcomm hgroup s t)
  simpa using this
