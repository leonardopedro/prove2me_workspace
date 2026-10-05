-- Generated from ChapterNsScalarVectorCurry.lean — solution of BookProof.NsScalarVectorCurry.eLpNorm_two_sq'
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
import Theorems.Thm_BookProof_NsScalarVectorCurry_eLpNorm_two_sq
open BookProof.NsScalarVectorCurry



open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]

set_option maxHeartbeats 1000000 in
theorem solution {X : Type*} [MeasurableSpace X] {E : Type*} [NormedAddCommGroup E]
    (ρ : Measure X) (h : X → E) : (eLpNorm h 2 ρ) ^ 2 = ∫⁻ x, ‖h x‖ₑ ^ 2 ∂ρ := by

  rw [eLpNorm_two_sq]
  simp_rw [ENNReal.rpow_two]
