-- Generated from ChapterBornMeasure.lean — theorem BookProof.ChapterBornMeasure.norm_evolve
import Mathlib
import Definitions.Def_ChapterBornMeasure
import Definitions.Def_ChapterContinuityUnitary
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterBornMeasure

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


open MeasureTheory
open scoped ENNReal



theorem BookProof.ChapterBornMeasure.norm_evolve (H : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) (hH : IsSelfAdjoint H) (t : ℝ)
    (psi : Lp ℂ 2 μ) : ‖evolve H t psi‖ = ‖psi‖ := by sorry
