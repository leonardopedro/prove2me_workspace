-- Generated from ChapterG2.lean — theorem BookProof.ChapterG2.integral_haarAverage
import Mathlib
import Definitions.Def_ChapterG2
open BookProof.ChapterG2

variable {Ω : Type*} [MeasurableSpace Ω]
variable {A : Type*} [CommRing A] (Q : A)
variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]


open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

theorem BookProof.ChapterG2.integral_haarAverage [MeasurableSpace X] [MeasurableSMul G X]
    [MeasurableMul G]
    (μ : Measure X) [IsProbabilityMeasure μ]
    (hμ : ∀ g : G, MeasurePreserving (fun x : X => g • x) μ μ)
    (f : X → ℝ)
    (hint : Integrable (fun p : G × X => f (p.1⁻¹ • p.2)) (μG.prod μ)) :
    ∫ x, haarAverage (μG := by sorry
