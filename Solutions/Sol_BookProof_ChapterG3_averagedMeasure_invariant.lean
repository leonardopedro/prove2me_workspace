-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.averagedMeasure_invariant
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (G : Type*) [Group G] [Fintype G]
    {Z : Type*} [MeasurableSpace Z] [MulAction G Z]
    (hmeas : ∀ g : G, Measurable (fun x : Z => g • x))
    (μ : Measure Z) (h : G) :
    (averagedMeasure G μ).map (fun x => h • x) = averagedMeasure G μ := by

  rw [averagedMeasure, Measure.map_smul]
  congr 1
  have hmap : Measure.map (fun x => h • x) (∑ g : G, μ.map (fun x => g • x))
      = ∑ g : G, Measure.map (fun x => h • x) (μ.map (fun x => g • x)) := by
    rw [← Measure.mapₗ_apply_of_measurable (hmeas h), map_sum]
    apply Finset.sum_congr rfl
    intro g _
    rw [Measure.mapₗ_apply_of_measurable (hmeas h)]
  rw [hmap, ← Equiv.sum_comp (Equiv.mulLeft h) (fun g => μ.map (fun x => g • x))]
  apply Finset.sum_congr rfl
  intro g _
  rw [Measure.map_map (hmeas h) (hmeas g)]
  congr 1
  ext x
  simp [mul_smul, Equiv.mulLeft]
