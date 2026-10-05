-- Generated from ChapterG.lean — solution of BookProof.ChapterG.evolution_conserves_probability
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]
variable {A : Type*} [Ring A]

set_option maxHeartbeats 1000000 in
theorem solution {X : Type*} [MeasurableSpace X]
    (μ : Measure X) [IsProbabilityMeasure μ] (T : X → X) (hT : Measurable T) :
    IsProbabilityMeasure (μ.map T) := MeasureTheory.Measure.isProbabilityMeasure_map hT.aemeasurable
