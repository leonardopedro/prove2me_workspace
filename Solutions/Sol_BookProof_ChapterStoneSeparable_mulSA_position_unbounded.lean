-- Generated from ChapterStoneSeparable.lean — solution of BookProof.ChapterStoneSeparable.mulSA_position_unbounded
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Theorems.Thm_BookProof_ChapterUnboundedPosition_position_unbounded
open BookProof.ChapterStoneSeparable



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ x : (mulSA positionField).domain,
      ‖(mulSA positionField).op x‖ ≤ C * ‖(x : L2Z)‖ := position_unbounded
