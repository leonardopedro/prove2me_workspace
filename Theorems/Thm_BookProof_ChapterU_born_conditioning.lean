-- Generated from ChapterU.lean — theorem BookProof.ChapterU.born_conditioning
import Mathlib
import Definitions.Def_ChapterU
open BookProof.ChapterU

variable {X : Type*} [MeasurableSpace X]
variable (R M N : Type*) [CommRing R] [AddCommGroup M] [Module R M]
  [AddCommGroup N] [Module R N]
variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

theorem BookProof.ChapterU.born_conditioning (Ψ : X → ℂ) (μ : Measure X) (E : Set X)
    (hE : MeasurableSet E) (hpos : bornMeasure Ψ μ E ≠ 0)
    (_hfin : bornMeasure Ψ μ E ≠ ∞) :
    bornMeasure (conditionedState Ψ μ E) μ = (bornMeasure Ψ μ)[|E] := by sorry
