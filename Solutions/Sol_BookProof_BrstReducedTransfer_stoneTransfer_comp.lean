-- Generated from ChapterBrstReducedTransfer.lean — solution of BookProof.BrstReducedTransfer.stoneTransfer_comp
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
import Theorems.Thm_BookProof_BrstReducedTransfer_transfer_comp
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_apply_stoneU
open BookProof.BrstReducedTransfer




open BookProof BookProof.ChapterStoneResolvent


variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]

variable (Om : H →L[ℂ] H)

variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]
variable (Om : H →L[ℂ] H)
variable {Om}
variable (Om)
variable (U : ℝ → (H →L[ℂ] H)) (hcomm : ∀ (t : ℝ) (y : H), U t (Om y) = Om (U t y))
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) (Om : H →L[ℂ] H)
variable (hcomm : ∀ (t : ℝ) (y : H), T.stoneU t (Om y) = Om (T.stoneU t y))

set_option maxHeartbeats 1000000 in
theorem solution (s t : ℝ) :
    (stoneTransfer T Om hcomm s).comp (stoneTransfer T Om hcomm t)
      = stoneTransfer T Om hcomm (s + t) := transfer_comp Om _ hcomm (fun s t x => T.stoneU_apply_stoneU s t x) s t
