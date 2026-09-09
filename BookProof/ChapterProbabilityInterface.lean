import Mathlib

/-!
# Probability as an interface between measurable theories

A measurable equivalence transports a probability law by `Measure.map`; the
inverse transports it back.  This gives a rigorous form of translation between
isomorphic standard measurable presentations without claiming that arbitrary
unrelated standard probability spaces are isomorphic.
-/

open MeasureTheory

namespace BookProof.ChapterProbabilityInterface

/-- Transport a law across a measurable equivalence. -/
noncomputable def transportMeasure {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X) : Measure Y :=
  Measure.map e μ

/-- Transport across a measurable equivalence and then back recovers the law. -/
theorem transportMeasure_symm {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X) :
    transportMeasure e.symm (transportMeasure e μ) = μ := by
  simp [transportMeasure]

/-- Probability is preserved by translation through a measurable equivalence. -/
theorem transportMeasure_isProbability {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X)
    [IsProbabilityMeasure μ] : IsProbabilityMeasure (transportMeasure e μ) := by
  exact Measure.isProbabilityMeasure_map e.measurable.aemeasurable

/-- Events translate with exactly the same probability. -/
theorem translated_event_probability {X Y : Type*} [MeasurableSpace X]
    [MeasurableSpace Y] (e : X ≃ᵐ Y) (μ : Measure X)
    (s : Set Y) (hs : MeasurableSet s) :
    transportMeasure e μ s = μ (e ⁻¹' s) := by
  rw [transportMeasure, MeasureTheory.Measure.map_apply e.measurable hs]

end BookProof.ChapterProbabilityInterface
