-- Generated from ChapterBrstReducedTransfer.lean — solution of BookProof.BrstReducedTransfer.stoneU_sub_mem_exactStates_inc
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.BrstReducedTransfer




open BookProof BookProof.ChapterStoneResolvent




variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) (Om : H →L[ℂ] H)
variable (hcomm : ∀ (t : ℝ) (y : H), T.stoneU t (Om y) = Om (T.stoneU t y))

set_option maxHeartbeats 1000000 in

include hcomm in
theorem solution (t : ℝ) {x y : H} (h : x - y ∈ exactStates Om) :
    T.stoneU t x - T.stoneU t y ∈ exactStates Om := by
  rw [← map_sub]
  exact exactStates_invariant (f := T.stoneU t) (hcomm t) _ h

