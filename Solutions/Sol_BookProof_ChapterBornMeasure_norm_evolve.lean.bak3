-- Generated from ChapterBornMeasure.lean — solution of BookProof.ChapterBornMeasure.norm_evolve
import Mathlib
import Definitions.Def_ChapterBornMeasure
import Theorems.Thm_BookProof_ChapterContinuityUnitary_exp_smul_I_unitary
open BookProof.ChapterBornMeasure



open MeasureTheory
open scoped ENNReal


variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

set_option maxHeartbeats 1000000 in
theorem solution (H : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) (hH : IsSelfAdjoint H) (t : ℝ)
    (psi : Lp ℂ 2 μ) : ‖evolve H t psi‖ = ‖psi‖ :=
  BookProof.ChapterContinuityUnitaryInfinite.norm_of_unitary _
      (BookProof.ChapterContinuityUnitaryInfinite.exp_smul_I_unitary H hH t).1 psi
