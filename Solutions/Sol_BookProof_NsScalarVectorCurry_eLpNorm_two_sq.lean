-- Generated from ChapterNsScalarVectorCurry.lean — solution of BookProof.NsScalarVectorCurry.eLpNorm_two_sq
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
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
    (ρ : Measure X) (h : X → E) : (eLpNorm h 2 ρ) ^ 2 = ∫⁻ x, ‖h x‖ₑ ^ (2 : ℝ) ∂ρ := by

  rw [eLpNorm_eq_eLpNorm' (by norm_num) (by norm_num), eLpNorm'_eq_lintegral_enorm]
  rw [show ((2 : ℝ≥0∞).toReal) = (2 : ℝ) by norm_num, one_div]
  exact ENNReal.rpow_inv_natCast_pow (n := 2) (by norm_num) _
