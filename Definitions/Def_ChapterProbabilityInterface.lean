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







end BookProof.ChapterProbabilityInterface
