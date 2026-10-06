-- Generated from ChapterStoneConverse.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.gen_stoneU_eq
import Mathlib
import Definitions.Def_ChapterStoneConverse
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_gen_stoneU_apply_eq_domain
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
variable (G : WeakMeasurableUnitaryGroup H)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : G.gen.stoneU t = G.U t :=
   G.gen.stoneU t = G.U t := by
    have hall := Continuous.ext_on G.denseDomain (G.gen.stoneU t).continuous (G.U t).continuous
      (fun y hy => G.gen_stoneU_apply_eq_domain t ⟨y, hy⟩)
    ext x
