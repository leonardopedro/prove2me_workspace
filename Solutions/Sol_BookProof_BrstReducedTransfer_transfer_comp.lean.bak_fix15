-- Generated from ChapterBrstReducedTransfer.lean — solution of BookProof.BrstReducedTransfer.transfer_comp
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
theorem solution (hgroup : ∀ (s t : ℝ) (x : H), U s (U t x) = U (s + t) x) (s t : ℝ) :
    (transfer Om U hcomm s).comp (transfer Om U hcomm t) = transfer Om U hcomm (s + t) := by

  refine LinearMap.ext fun c => ?_
  induction c using Submodule.Quotient.induction_on with
  | H x =>
    simp only [LinearMap.comp_apply, transfer_mk]
    congr 1
    exact Subtype.ext (hgroup s t x)
