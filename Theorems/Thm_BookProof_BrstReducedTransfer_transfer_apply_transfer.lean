-- Generated from ChapterBrstReducedTransfer.lean — theorem BookProof.BrstReducedTransfer.transfer_apply_transfer
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
open BookProof.BrstReducedTransfer



open BookProof BookProof.ChapterStoneResolvent


variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]

variable (Om : H →L[ℂ] H)

variable {Om}
variable (Om)
variable (U : ℝ → (H →L[ℂ] H)) (hcomm : ∀ (t : ℝ) (y : H), U t (Om y) = Om (U t y))

theorem BookProof.BrstReducedTransfer.transfer_apply_transfer (hgroup : ∀ (s t : ℝ) (x : H), U s (U t x) = U (s + t) x)
    (s t : ℝ) (c : Cohomology Om) :
    transfer Om U hcomm s (transfer Om U hcomm t c) = transfer Om U hcomm (s + t) c := by sorry
