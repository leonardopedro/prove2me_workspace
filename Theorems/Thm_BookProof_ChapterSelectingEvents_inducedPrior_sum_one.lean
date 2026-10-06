-- Generated from ChapterSelectingEvents.lean — theorem BookProof.ChapterSelectingEvents.inducedPrior_sum_one
import Mathlib
import Definitions.Def_ChapterSelectingEvents
import Definitions.Def_ChapterDeepLearningSampling
open BookProof.ChapterDeepLearningSampling
open BookProof.ChapterSelectingEvents

variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable {Ω Data : Type*} [MeasurableSpace Ω]
variable {X : Type*} [MeasurableSpace X] (μ : Measure X) [IsProbabilityMeasure μ]
variable {Seed Model : Type*} [Fintype Seed] [Fintype Model] [DecidableEq Model]


open scoped BigOperators
open MeasureTheory ProbabilityTheory



theorem BookProof.ChapterSelectingEvents.inducedPrior_sum_one (seedProb : Seed → ℝ) (train : Seed → Model)
    (_hnonneg : ∀ s, 0 ≤ seedProb s) (hsum : ∑ s, seedProb s = 1) :
    ∑ m, inducedPrior seedProb train m = 1 := by sorry
