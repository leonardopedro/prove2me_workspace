-- Generated from ChapterSelectingEvents.lean — theorem BookProof.ChapterSelectingEvents.exists_regular_conditional_probability
import Mathlib
import Definitions.Def_ChapterSelectingEvents
open BookProof.ChapterSelectingEvents

variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable {Ω Data : Type*} [MeasurableSpace Ω]


open scoped BigOperators
open MeasureTheory ProbabilityTheory



theorem BookProof.ChapterSelectingEvents.exists_regular_conditional_probability
    [StandardBorelSpace Ω] [Nonempty Ω] [MeasurableSpace Data]
    (μ : Measure Ω) [IsFiniteMeasure μ] (X : Ω → Data) :
    ∃ κ : Kernel Data Ω, IsMarkovKernel κ ∧
      (μ.map X) ⊗ₘ κ = μ.map (fun ω => (X ω, ω)) := by sorry
