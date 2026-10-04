-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.haarAverage_invariant
import Mathlib
import Definitions.Def_ChapterG2
import Definitions.Def_ChapterA4
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)
variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.haarAverage_invariant [MeasurableMul G] (f : X → ℝ) (g : G) (x : X) :
    haarAverage (μG := by sorry
