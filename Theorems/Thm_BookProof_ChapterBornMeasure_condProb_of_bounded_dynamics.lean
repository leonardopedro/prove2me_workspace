-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.condProb_of_bounded_dynamics
import Mathlib
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


open MeasureTheory
open scoped ENNReal



theorem BookProof.ChapterBornMeasure.condProb_of_bounded_dynamics (H : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) (hH : IsSelfAdjoint H)
    (psi : Lp ℂ 2 μ) (hpsi : ‖psi‖ = 1) (t : ℝ) :
    IsProbabilityMeasure (bornMeasure (evolve H t psi)) ∧
      bornMeasure (evolve H t psi) ≪ μ := by sorry
