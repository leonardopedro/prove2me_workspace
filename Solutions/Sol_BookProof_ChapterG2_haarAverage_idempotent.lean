-- Generated from ChapterG2.lean — solution of BookProof.ChapterG2.haarAverage_idempotent
import Mathlib
import Definitions.Def_ChapterG2
import Theorems.Thm_BookProof_ChapterG_haarAverage_of_invariant
import Theorems.Thm_BookProof_ChapterG_haarAverage_smul
open BookProof.ChapterG2



open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)
variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

set_option maxHeartbeats 1000000 in
theorem solution [MeasurableMul G] (f : X → ℝ) :
    haarAverage (μG := haarAverage_of_invariant (haarAverage (μG := μG) f) (haarAverage_smul f)
