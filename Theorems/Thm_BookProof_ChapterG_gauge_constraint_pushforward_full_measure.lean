-- Generated from ChapterG.lean — theorem BookProof.ChapterG.gauge_constraint_pushforward_full_measure
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix
open MeasureTheory

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

theorem BookProof.ChapterG.gauge_constraint_pushforward_full_measure
    {X : Type*} [MeasurableSpace X] (μ : Measure X) [IsProbabilityMeasure μ]
    (q : X → X) (hq : Measurable q)
    (C : Set X) (hC : MeasurableSet C)
    (hrange : ∀ x, q x ∈ C) :
    IsProbabilityMeasure (μ.map q) ∧ (μ.map q) C = 1 := by sorry
