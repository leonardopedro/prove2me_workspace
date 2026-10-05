-- Generated from ChapterL2FibreSum.lean — solution of BookProof.ChapterL2FibreSum.projCLM_apply
import Mathlib
import Definitions.Def_ChapterL2FibreSum



open MeasureTheory
open scoped InnerProductSpace



variable {X : Type*} [MeasurableSpace X] {μ : Measure X}

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (μ : Measure X) {E : Set X} (hE : MeasurableSet E)
    (f : Lp K 2 μ) : projCLM μ hE f = proj μ hE f := rfl
