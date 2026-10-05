-- Generated from ChapterG2.lean — solution of BookProof.ChapterG2.no_translation_invariant_probabilityMeasure
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2



open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution {G : Type*} [Group G]
    [Countable G] [Infinite G] [MeasurableSpace G] [MeasurableSingletonClass G] :
    ¬ ∃ μ : Measure G, IsProbabilityMeasure μ ∧ ∀ g x : G, μ {g * x} = μ {x} := by

  by_contra! h;
  obtain ⟨ μ, hμ₁, hμ₂ ⟩ := h;
  have h_singleton : ∀ g : G, μ {g} = μ {1} := by
    exact fun g => by simpa using hμ₂ g 1;
  have h_sum : ∑' g : G, μ {g} = 1 := by
    rw [ ← MeasureTheory.measure_iUnion ];
    · simp [ Set.iUnion_of_singleton ];
    · exact fun x y hxy => Set.disjoint_singleton.2 hxy;
    · exact fun g => MeasurableSingletonClass.measurableSet_singleton g;
  by_cases h : μ { 1 } = 0 <;> simp_all
