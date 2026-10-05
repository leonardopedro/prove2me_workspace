-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.averagedMeasure_isProbability
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
    (μ : Measure Z) [IsProbabilityMeasure μ] :
    IsProbabilityMeasure (averagedMeasure G μ) := by

  constructor
  rw [averagedMeasure, Measure.smul_apply, Measure.finset_sum_apply]
  have h1 : ∀ g : G, (μ.map (fun x => g • x)) Set.univ = 1 := by
    intro g
    rw [Measure.map_apply (hmeas g) MeasurableSet.univ]
    simp
  simp only [h1]
  rw [Finset.sum_const, Finset.card_univ, smul_eq_mul, nsmul_eq_mul, mul_one,
    ENNReal.inv_mul_cancel]
  · exact_mod_cast (Fintype.card_pos).ne'
  · exact ENNReal.natCast_ne_top _
