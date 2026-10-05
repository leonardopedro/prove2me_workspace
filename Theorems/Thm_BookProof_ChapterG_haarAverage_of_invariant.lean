-- Generated from ChapterG.lean — theorem BookProof.ChapterG.haarAverage_of_invariant
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.haarAverage_of_invariant (f : X → ℝ) (hf : ∀ g : G, ∀ x, f (g • x) = f x) :
    haarAverage (μG := by sorry
