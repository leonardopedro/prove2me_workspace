-- Generated from ChapterStoneSeparable.lean — solution of BookProof.ChapterStoneSeparable.stone_exists_unique_group
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Theorems.Thm_BookProof_ChapterStoneSeparable_eq_stoneU_of_hasDerivAt
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_ext_prime
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_hasDerivAt_stoneU_zero
open BookProof.ChapterStoneSeparable



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) :
    ∃! G : WeakMeasurableUnitaryGroup H,
      ∀ x : T.domain, HasDerivAt (fun t : ℝ => G.U t (x : H)) ((-Complex.I) • T.op x) 0 := by

  refine ⟨T.stoneGroup, fun x => T.hasDerivAt_stoneU_zero x, fun G hG => ?_⟩
  exact WeakMeasurableUnitaryGroup.ext_prime (fun t => eq_stoneU_of_hasDerivAt T G hG t)
