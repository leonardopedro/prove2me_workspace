-- Generated from ChapterG.lean — theorem BookProof.ChapterG.haarAverage_smul
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix
open MeasureTheory

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

theorem BookProof.ChapterG.haarAverage_smul [MeasurableMul G]
    (f : X → ℝ) (g₀ : G) (x : X) :
    haarAverage (μG := by sorry
