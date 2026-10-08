-- Generated from ChapterSelectingEvents.lean — theorem BookProof.ChapterSelectingEvents.exists_continuous_atomic_decomposition
import Mathlib
import Definitions.Def_ChapterSelectingEvents
open BookProof.ChapterSelectingEvents


open scoped BigOperators
open MeasureTheory ProbabilityTheory


variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {Ω Data : Type*} [MeasurableSpace Ω]
variable {X : Type*} [MeasurableSpace X] (μ : Measure X) [IsProbabilityMeasure μ]

theorem BookProof.ChapterSelectingEvents.exists_continuous_atomic_decomposition [MeasurableSingletonClass X] :
    ∃ cont atom : Measure X, μ = cont + atom ∧ NullSingletonClass cont ∧
      ∃ A : Set X, A.Countable ∧ atom Aᶜ = 0 := by sorry
