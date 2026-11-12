-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.haarAverage_invariant
import Mathlib
import Definitions.Def_ChapterG2
import Definitions.Def_ChapterG
open BookProof.ChapterG
open BookProof.ChapterG2


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory



variable {Ω : Type*} [MeasurableSpace Ω]



















open BookProof.ChapterG

variable {A : Type*} [CommRing A] (Q : A)





















open BookProof.ChapterG

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]


theorem BookProof.ChapterG2.haarAverage_invariant [MeasurableMul G] (f : X → ℝ) (g : G) (x : X) :
    haarAverage (μG := μG) f (g • x) = haarAverage (μG := μG) f x := by sorry
