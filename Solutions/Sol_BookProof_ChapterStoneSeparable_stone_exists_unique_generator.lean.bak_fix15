-- Generated from ChapterStoneSeparable.lean — solution of BookProof.ChapterStoneSeparable.stone_exists_unique_generator
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_ext_prime
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_gen_stoneU_eq
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_gen_stoneGroup_eq
open BookProof.ChapterStoneSeparable



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (G : WeakMeasurableUnitaryGroup H) :
    ∃! T : UnboundedSelfAdjoint H, ∀ t : ℝ, T.stoneU t = G.U t := by

  refine ⟨G.gen, fun t => G.gen_stoneU_eq t, fun T hT => ?_⟩
  have hgroup : T.stoneGroup = G := WeakMeasurableUnitaryGroup.ext_prime hT
  rw [← T.gen_stoneGroup_eq, hgroup]
