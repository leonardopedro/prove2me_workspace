-- Generated from ChapterU.lean — theorem BookProof.ChapterU.born_conditioning
import Mathlib
import Definitions.Def_ChapterU
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure
open BookProof.ChapterU

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

theorem BookProof.ChapterU.born_conditioning (Ψ : X → ℂ) (μ : Measure X) (E : Set X)
    (hE : MeasurableSet E) (hpos : bornMeasure Ψ μ E ≠ 0)
    (_hfin : bornMeasure Ψ μ E ≠ ∞) :
    bornMeasure (conditionedState Ψ μ E) μ = (bornMeasure Ψ μ)[|E] := by sorry
