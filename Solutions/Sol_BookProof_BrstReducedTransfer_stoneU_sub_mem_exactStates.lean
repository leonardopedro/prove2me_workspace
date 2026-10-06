-- Generated from ChapterBrstReducedTransfer.lean — solution of BookProof.BrstReducedTransfer.stoneU_sub_mem_exactStates
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
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) (Om : H →L[ℂ] H)
variable (hcomm : ∀ (t : ℝ) (y : H), T.stoneU t (Om y) = Om (T.stoneU t y))

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) {x y : H} (h : x - y ∈ exactStates Om) :
    T.stoneU t x - T.stoneU t y ∈ exactStates Om := by

  rw [← map_sub]
  exact exactStates_invariant (f := T.stoneU t) (hcomm t) _ h
