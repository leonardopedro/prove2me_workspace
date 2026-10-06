-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.image_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
import Theorems.Thm_BookProof_OdeUnitaryFlow_mob_mem_flowDom_neg
import Theorems.Thm_BookProof_OdeUnitaryFlow_mob_neg_mob
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) : mob t '' flowDom t = flowDom (-t) := by

  apply Set.Subset.antisymm
  · rintro y ⟨x, hx, rfl⟩
    exact mob_mem_flowDom_neg t x hx
  · intro y hy
    refine ⟨mob (-t) y, ?_, ?_⟩
    · have h := mob_mem_flowDom_neg (-t) y hy
      simpa using h
    · have h := mob_neg_mob (-t) y hy
      simpa using h
