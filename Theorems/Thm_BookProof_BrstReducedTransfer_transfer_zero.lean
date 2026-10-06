-- Generated from ChapterBrstReducedTransfer.lean — theorem BookProof.BrstReducedTransfer.transfer_zero
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
open BookProof.BrstReducedTransfer

variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]
variable (Om : H →L[ℂ] H)
variable {Om}
variable (Om)
variable (U : ℝ → (H →L[ℂ] H)) (hcomm : ∀ (t : ℝ) (y : H), U t (Om y) = Om (U t y))



open BookProof BookProof.ChapterStoneResolvent




theorem BookProof.BrstReducedTransfer.transfer_zero (hzero : ∀ x : H, U 0 x = x) :
    transfer Om U hcomm 0 = LinearMap.id := by sorry
